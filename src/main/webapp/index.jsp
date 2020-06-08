<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Hello, world!</title>
</head>
<body>
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

<div class="container">
    <div class="row pt-3">
        <h4>
            Бронирование месте на сеанс
        </h4>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th style="width: 120px;">Ряд / Место</th>
                <th>1</th>
                <th>2</th>
                <th>3</th>
            </tr>
            </thead>
            <tbody id="board">
            </tbody>
        </table>
        <div class="row float-right">
            <button type="button" class="btn btn-success">Оплатить</button>
        </div>
    </div>
</div>
<script>
    /**
     * List of input-seats.
     * @type {NodeListOf<Element>}
     */
    let seats = document.querySelectorAll('input[name="seat"]')
    let jsn;
    /**
     * Return all seat from json and render them.
     * Every 30 seconds page auto-reload.
     */
    window.onload = function () {
        fetch('http://localhost:8081/cinema/hall',
            {
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            }
        ).then(response => response.json())
            .then(data => {
                jsn = data.busyPlaces;
                for (let i = 0, count = 0; i < 3; i++) {
                    let tr = document.createElement("tr");
                    let td = document.createElement("td");
                    td.appendChild(document.createTextNode(i + 1));
                    tr.appendChild(td);
                    for (let j = 0; j < 3; j++) {
                        let td = document.createElement("td");
                        let seat = jsn[count++];
                        let input = document.createElement('input');
                        input.type = 'checkbox';
                        input.name = 'seat';
                        input.value = seat.row + '/' + seat.place + '/' + seat.id;
                        input.disabled = seat.busy;
                        td.appendChild(document.createTextNode('Ряд: ' + seat.row + ' Место: ' + seat.place + ' Цена: ' + seat.price + ' '))
                        td.appendChild(input);
                        tr.appendChild(td);
                    }
                    document.querySelector('#board').appendChild(tr);
                }
            }).catch(error => console.error(error))
        setTimeout('location.reload (true)', 30000);
    }
    /**
     * Submit button.
     * @type {HTMLButtonElement}
     */
    let btnPay = document.querySelector("button");
    /**
     * Save tickets to coockies and redirect to payment page.
     */
    btnPay.addEventListener("click", () => {
        seats = document.querySelectorAll('input[name="seat"]')
        let price = 0;
        let i = 0;
        Array.from(seats).map(e => {
            if (e.checked === true) {
                document.cookie = 'ticket-' + i++ + "=" + e.value;
                price += 500;
            }
        });
        document.cookie = 'seatsLength=' + i;
        document.cookie = 'price=' + price;
        window.location.href = "${pageContext.servletContext.contextPath}/payment.jsp"
    })
</script>
</body>
</html>
