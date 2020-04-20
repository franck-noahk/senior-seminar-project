import {
    getAdminPriv
} from "./firestore-db-func.js";
import {
    uid
} from "./user.js";

window.onload = verify;

function verify() {

    console.log(window.location.pathname);
    if (uid && getAdminPriv()) {
        //TODO: they are admin

    } else if (uid) {

        //TODO: They are logedin
        if (window.location.pathname == 'my-club.html' || window.location.pathname == 'create-events.html' || window.location.pathname == 'my-club.html') {
            window.location.href = "https://senior-seminar-project-dev.web.app/";
        }

        let toRemove = document.getElementsByClassName("admin");
        for (var i = toRemove.length - 1; i >= 0; --i) {
            toRemove[i].remove();
        }


    } else {
        //TODO: normal user
        if (window.location.pathname == 'my-club.html' || window.location.pathname == 'create-events.html' || window.location.pathname == 'my-club.html') {
            window.location.href = "https://senior-seminar-project-dev.web.app/login.html";
        }
        let toRemove = document.getElementsByClassName('admin');
        if (toRemove)
            for (var i = toRemove.length - 1; i >= 0; --i) {
                toRemove[i].remove();
            }
        toRemove = document.getElementsByClassName('logged-in');
        if (toRemove)
            for (var i = toRemove.length - 1; i >= 0; --i) {
                toRemove[i].remove();
            }
    }
    // verify();
}