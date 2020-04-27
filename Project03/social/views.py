from django.http import HttpResponse,HttpResponseNotFound
from django.shortcuts import render,redirect,get_object_or_404
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages

# For Obejctive 3
from datetime import date

# For Objective 6
from django.core.exceptions import ObjectDoesNotExist

from . import models

def messages_view(request):
    """Private Page Only an Authorized User Can View, renders messages page
       Displays all posts and friends, also allows user to make new posts and like posts
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render private.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)


        # TODO Objective 9: query for posts (HINT only return posts needed to be displayed)

        all_posts = models.Post.objects.all().order_by('-timestamp')
        post_disp = request.session.get('post_disp', 1)
        posts = list(all_posts)[:post_disp]

        # TODO Objective 10: check if user has like post, attach as a new attribute to each post

        context = { 'user_info' : user_info,
                    'posts' : posts}
        return render(request,'messages.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def account_view(request):
    """Private Page Only an Authorized User Can View, allows user to update
       their account information (i.e UserInfo fields), including changing
       their password
    Parameters
    ---------
      request: (HttpRequest) should be either a GET or POST
    Returns
    --------
      out: (HttpResponse)
                 GET - if user is authenticated, will render account.djhtml
                 POST - handle form submissions for changing password, or User Info
                        (if handled in this view)
    """
    # TODO Objective 3: Create Forms and Handle POST to Update UserInfo / Password
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        if request.method == 'POST':
            # Password
            form_password = PasswordChangeForm(request.user, request.POST)
            if form_password.is_valid():
                user = form_password.save()
                update_session_auth_hash(request, user)

            # Other infoamtion
            employment = request.POST.get('employment')
            if employment:
                user_info.employment = employment

            location = request.POST.get('location')
            if location:
                user_info.location = location

            birthday = request.POST.get('birthday')
            if birthday:
                user_info.birthday = date.fromisoformat(birthday)

            interests = request.POST.get('interests', 'Unspecified')
            # TODO Add option to remove interests
            if interests:
                for interest in interests.split(','):
                    interest_tmp = interest.strip().lower()


                    try:
                        models.Interest.objects.get(label = interest_tmp).delete()
                    except ObjectDoesNotExist:
                        interest_tmp_model = models.Interest(interest_tmp)
                        interest_tmp_model.save()
                        user_info.interests.add(interest_tmp_model)
                        user_info.save()
        else:
            form_password = PasswordChangeForm(request.user)

        # TODO make interests list to render in social_base.djhtml
        # intrests_out = list(user_info.Interests.objects.all())
        context = {'user_info' : user_info,
                   'form_password' : form_password}
        return render(request,'account.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')


def people_view(request):
    """Private Page Only an Authorized User Can View, renders people page
       Displays all users who are not friends of the current user and friend requests
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render people.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        # TODO Objective 4: create a list of all users who aren't friends to the current user (and limit size)
        # TODO exclude friends

        all_people = models.UserInfo.objects.all().exclude(user=user_info.user)
        not_friends = []

        for person in all_people:
            if user_info not in person.friends.all():
                not_friends.append(person)

        ppl_disp = request.session.get('ppl_disp', 1)
        out_people = not_friends[0:ppl_disp]
        # TODO Objective 5: create a list of all friend requests to current user
        friend_requests =  models.FriendRequest.objects.filter(to_user=user_info)
        context = { 'user_info' : user_info,
                    'out_people' : out_people,
                    'friend_requests' : friend_requests }

        return render(request,'people.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def like_view(request):
    '''Handles POST Request recieved from clicking Like button in messages.djhtml,
       sent by messages.js, by updating the corrresponding entry in the Post Model
       by adding user to its likes field
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postID,
                                a string of format post-n where n is an id in the
                                Post model

	Returns
	-------
   	  out : (HttpResponse) - queries the Post model for the corresponding postID, and
                             adds the current user to the likes attribute, then returns
                             an empty HttpResponse, 404 if any error occurs
    '''
    if request.method == 'POST':
        postIDReq = request.POST.get('post_id')
        if postIDReq is not None:
            # remove 'post-' from postID and convert to int
            # TODO Objective 10: parse post id from postIDReq
            postID = int(postIDReq[2:])
            post_inst = models.Post.objects.get(id = postID)
            if request.user.is_authenticated:
                # TODO Objective 10: update Post model entry to add user to likes field
                user_info = models.UserInfo.objects.get(user=request.user)
                if user_info not in post_inst.likes.all():
                    post_inst.likes.add(user_info)
                messages_view(request)
                # return status='success'
                return HttpResponse()
            else:
                return redirect('login:login_view')

    return HttpResponseNotFound('like_view called without postID in POST')

def post_submit_view(request):
    '''Handles POST Request recieved from submitting a post in messages.djhtml by adding an entry
       to the Post Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postContent, a string of content

	Returns
	-------
   	  out : (HttpResponse) - after adding a new entry to the POST model, returns an empty HttpResponse,
                             or 404 if any error occurs
    '''
    postContent = request.POST.get('postContent')
    if postContent is not None:
        if request.user.is_authenticated:
            # TODO Objective 8: Add a new entry to the Post model
            user_info = models.UserInfo.objects.get(user=request.user)
            models.Post.objects.create(owner= user_info, content = postContent)
            # return status='success'
            messages_view(request)
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('post_submit_view called without postContent in POST')

def more_post_view(request):
    '''Handles POST Request requesting to increase the amount of Post's displayed in messages.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating hte num_posts sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of posts dispalyed

        # TODO Objective 9: update how many posts are displayed/returned by messages_view
        if request.method == 'POST':
            post_disp = request.session.get('post_disp', 1)
            request.session['post_disp'] = post_disp + 1

        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')

def more_ppl_view(request):
    '''Handles POST Request requesting to increase the amount of People displayed in people.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating the num ppl sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of people dispalyed

        # TODO Objective 4: incretment session variable for keeping track of num ppl displayed
        if request.method == 'POST':
            ppl_disp = request.session.get('ppl_disp', 1)
            request.session['ppl_disp'] = ppl_disp + 1

        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')

def friend_request_view(request):
    '''Handles POST Request recieved from clicking Friend Request button in people.djhtml,
       sent by people.js, by adding an entry to the FriendRequest Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute frID,
                                a string of format fr-name where name is a valid username

	Returns
	-------
   	  out : (HttpResponse) - adds an etnry to the FriendRequest Model, then returns
                             an empty HttpResponse, 404 if POST data doesn't contain frID
    '''
    frID = request.POST.get('frID')
    if frID is not None:
        # remove 'fr-' from frID
        username = frID[3:]
        if request.user.is_authenticated:
            # TODO Objective 5: add new entry to FriendRequest

            from_user = models.UserInfo.objects.get(user=request.user)
            to_user_tmp = models.User.objects.get(username=username)
            to_user = models.UserInfo.objects.get(user=to_user_tmp)

            create_request= True

            for req in models.FriendRequest.objects.all():
                if req.to_user == to_user and req.from_user == from_user:
                    create_request = False

                if req.to_user == from_user and req.from_user == to_user:
                    create_request = False
                    models.FriendRequest.objects.get(from_user=to_user, to_user=from_user).delete()
                    to_user.friends.add(from_user)
                    from_user.friends.add(to_user)

            if create_request:
                models.FriendRequest.objects.create(to_user= to_user, from_user = from_user)

            # return status='success'
            people_view(request)
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('friend_request_view called without frID in POST')

def accept_decline_view(request):
    '''Handles POST Request recieved from accepting or declining a friend request in people.djhtml,
       sent by people.js, deletes corresponding FriendRequest entry and adds to users friends relation
       if accepted
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute decision,
                                a string of format A-name or D-name where name is
                                a valid username (the user who sent the request)

	Returns
	-------
   	  out : (HttpResponse) - deletes entry to FriendRequest table, appends friends in UserInfo Models,
                             then returns an empty HttpResponse, 404 if POST data doesn't contain decision
    '''
    data = request.POST.get('decision')
    if data is not None:
        # TODO Objective 6: parse decision from data
        if request.user.is_authenticated:
            request_username = data[2:]
            request_decision = data[0:1]
            # TODO Objective 6: delete FriendRequest entry and update friends in both Users
            from_user_tmp = models.User.objects.get(username=request_username)
            from_user = models.UserInfo.objects.get(user=from_user_tmp)
            to_user = models.UserInfo.objects.get(user=request.user)
            if request_decision == 'A':
                to_user.friends.add(from_user)
                from_user.friends.add(to_user)

            models.FriendRequest.objects.get(from_user=from_user, to_user=to_user).delete()
            try:
                models.FriendRequest.objects.get(from_user=to_user, to_user=from_user).delete()
            except ObjectDoesNotExist:
                pass

            people_view(request)
            # return status='success'
            return HttpResponse(people_view(request))
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('accept-decline-view called without decision in POST')
