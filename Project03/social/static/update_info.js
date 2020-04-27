$(document).ready(function() {
    function onSubmit(event) {
        event.preventDefault();
        let form = $(this);
        let employment = form.find("input[name='employment']").val();
        let location = form.find("input[name='location']").val();
        let birthday = form.find("input[name='birthday']").val();
        let interests = form.find("input[name='interests']").val();
        // IMPT CHANGE THE URL PATH LATER
        let url_path = '/e/macid/account/';
        let data = {'employment': employment,
                    'location': location,
                    'birthday': birthday.
                    'interests': interests};
        $.post(url_path,
               data);
    }
    $("#form_info").submit(onSubmit);

})
