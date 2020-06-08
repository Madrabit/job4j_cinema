<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css"/>
    <title>Hello, world!</title>
</head>
<body>

<div class="container">
    <div class="row pt-3">
        <h3>
            Вы выбрали
            <ul id="seats">

            </ul>
            <div id="price"> Сумма : рублей.</div>
        </h3>
    </div>
    <div class="row">
        <form>
            <div class="form-group">
                <label for="username">ФИО</label>
                <input type="text" class="form-control" id="username" placeholder="ФИО">
                <div class="valid-inform  hidden" id="nameInvalid">Поле заполнено неверно</div>
            </div>
            <div class="form-group">
                <label for="phone">Номер телефона</label>
                <input type="number" class="form-control" id="phone" placeholder="Номер телефона">
                <div class="valid-inform  hidden" id="phoneInvalid">Поле заполнено неверно</div>
            </div>
            <button type="button" class="btn btn-success">Оплатить</button>
        </form>
    </div>
</div>
<script>
    function getCookie(cookieName) {
        let name = cookieName + "=";
        let decodedCookie = decodeURIComponent(document.cookie);
        let ca = decodedCookie.split(';');
        for (let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) === ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) === 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    let seatsArr = [];
    const seatsForJson = [];

    /**
     * Get tickets from coockies and render them.
     */
    window.onload = function () {
        document.querySelector('#price').textContent = "Сумма: " + getCookie('price') + " рублей.";
        let ul = document.querySelector("#seats");

        for (let i = 0; i < JSON.parse(getCookie('seatsLength')); i++) {
            seatsArr.push(getCookie('ticket-' + i));
        }
        seatsArr.map(e => {
            let li = document.createElement("li");
            let seat = e.split('/');
            seatsForJson.push(seat[2]);
            li.appendChild(document.createTextNode('Ряд: ' + seat[0] + ' Место: ' + seat[1]));
            ul.appendChild(li);
        });
    }

    /**
     * Submit button.
     * @type {HTMLButtonElement}
     */
    let btn = document.querySelector('button');
    /**
     * Validate then send to server: name, phone and chosen seats.
     */
    btn.addEventListener('click', () => {
        document.querySelectorAll('.valid-inform').forEach(el => el.classList.add('hidden'));
        let name = document.querySelector("#username").value;
        let phone = document.querySelector("#phone").value;
        if (name.trim() === "") {
            let error = document.querySelector('#nameInvalid');
            error.classList.remove('hidden');
        }
        if (phone.trim() === "") {
            let error = document.querySelector('#phoneInvalid');
            error.classList.remove('hidden');
        }
        if (name.trim() !== "" && phone.trim() !== "") {
            fetch('http://localhost:8081/cinema/payment',
                {
                    method: 'POST',
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({name: name, phone: phone, seats: [...seatsForJson]})
                }
            ).then(response => {
                let formDiv = document.querySelector(".container");
                let div = document.createElement("div");
                div.appendChild(document.createTextNode('Оплата просшла успешно.'));
                formDiv.appendChild(div);
            }).catch(error => console.error(error))
        }
    })
</script>
</body>
</html>
