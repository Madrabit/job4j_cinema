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
            <%--            <tr>--%>
            <%--                <th>1</th>--%>
            <%--                <td><input type="checkbox" name="seat" value="1.1"> Ряд 1, Место 1</td>--%>
            <%--                <td><input type="checkbox" name="seat" value="1.2"> Ряд 1, Место 2</td>--%>
            <%--                <td><input type="checkbox" name="seat" value="1.3"> Ряд 1, Место 3</td>--%>
            <%--            </tr>--%>
            <%--            <tr>--%>
            <%--                <th>2</th>--%>
            <%--                <td><input type="checkbox" name="seat" value="2.1"> Ряд 2, Место 1</td>--%>
            <%--                <td><input type="checkbox" name="seat" value="2.2"> Ряд 2, Место 2</td>--%>
            <%--                <td><input type="checkbox" name="seat" value="2.3"> Ряд 2, Место 3</td>--%>
            <%--            </tr>--%>
            <%--            <tr>--%>
            <%--                <th>3</th>--%>
            <%--                <td><input type="checkbox" name="seat" value="3.1"> Ряд 3, Место 1</td>--%>
            <%--                <td><input type="checkbox" name="seat" value="3.2"> Ряд 3, Место 2</td>--%>
            <%--                <td><input type="checkbox" name="seat" value="3.3"> Ряд 3, Место 3</td>--%>
            <%--            </tr>--%>
            </tbody>
        </table>
        <div class="row float-right">
            <button type="button" class="btn btn-success">Оплатить</button>
        </div>
    </div>
</div>
<script>
    let seats = document.querySelectorAll('input[name="seat"]')
    let jsn;
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
                // Array.from(seats).map( e => {
                jsn = data.busyPlaces;
                // for (let row in data.busyPlaces) {
                let rows = jsn.length / 3;
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
                        input.value = seat.row + '.' + seat.place;
                        input.disabled = seat.busy;
                        td.appendChild(document.createTextNode('Ряд: ' + seat.row + ' Место: ' + seat.place + ' Цена: ' + seat.price + ' '))
                        td.appendChild(input);
                        tr.appendChild(td);
                    }
                    document.querySelector('#board').appendChild(tr);
                }


                // let seat = e.split('.');
                // li.appendChild(document.createTextNode('Ряд: ' + seat[0] + ' Место: ' + seat[1]));
                // ul.appendChild(li);
                //
                // if (e.value == row + '.' + data.busyPlaces[row]) {
                //     e.disabled = true;
                // }
                // }

            }).catch(error => console.error(error))
        // })

    }
    let btnPay = document.querySelector("button");
    btnPay.addEventListener("click", () => {
        seats = document.querySelectorAll('input[name="seat"]')
        let occupied = [];
        let price = 0;
        let i = 0;
        Array.from(seats).map(e => {
            if (e.checked == true) {
                // occupied.push(e.value);
                let splited = e.value.split('.');
                document.cookie = 'ticket-' + i++ + "=" + e.value;
                price += 500;
            }
        });
        let jsonStr = JSON.stringify(occupied);
        // document.cookie = 'seats=' + jsonStr;
        document.cookie = 'seatsLength=' + i;
        document.cookie = 'price=' + price;
        window.location.href = "${pageContext.servletContext.contextPath}/payment.jsp"
    })


</script>
</body>
</html>
