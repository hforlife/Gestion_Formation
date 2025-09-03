<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <title>CERTIFICAT DE FORMATION QUALIFIANTE</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400..800&display=swap" rel="stylesheet">

    <style>
        @page {
            margin: 0;
            /* enlève les marges par défaut de DomPDF */
        }

        body {
            margin: 0;
            padding: 0;
            font-family: "Baloo 2", DejaVu Sans, sans-serif;
            text-align: center;
            position: relative;
        }

        .border {
            padding: 40px;
            box-sizing: border-box;
            min-height: 100vh;
            position: relative;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 40px;
            margin-bottom: 30px;
            padding-bottom: 120px;
            /* espace avant le hr */
        }

        .header img {
            height: 150px;
            /* taille augmentée mais contrôlée */
            object-fit: contain;
            position: absolute;
        }

        .header .left {
            left: 40px;
        }

        .header .right {
            right: 40px;
        }

        hr {
            border: none;
            border-top: 3px solid #3333ff;
            margin: 20px 0;
        }

        .content {
            margin-top: 20px;
            /* descend un peu pour respirer */
            border-bottom: 3px solid #3333ff;
            padding-bottom: 20px;
        }

        h1 {
            font-size: 24px;
            margin: 30px 0;
        }

        .name {
            background: #3333ff;
            color: white;
            font-size: 40px;
            font-weight: bold;
            padding: 20px 10px;
            margin: 20px 0;
        }

        .formation {
            color: #3333ff;
            font-size: 22px;
            font-weight: bold;
        }

        .blue {
            color: #3333ff;
        }

        .red {
            color: red;
        }

        .footer {
            background: #3333ff;
            color: white;
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            font-size: 12px;
            font-weight: bold;
            padding: 10px 0;
            margin: 5px 0;
        }

        .hidden {
            visibility: hidden;
        }
    </style>
</head>

<body>
    <div class="border">
        <div class="header">
            <img src="{{ public_path('asset/img/logo_formaplus.png') }}" class="left">
            <img src="{{ public_path('asset/img/hat.png') }}" class="right">
        </div>

        <hr>

        <div class="content">
            <h1>CERTIFICAT DE FORMATION QUALIFIANTE</h1>
            <p>La Direction du centre de formation <span class="blue">Forma+</span> certifie que:</p>

            <div class="name">MME/MR {{ $nom }}</div>

            <p>A suivi du <span class="red">{{ $debut }}</span> au <span
                    class="red">{{ $fin }}</span> la formation profil</p>
            <div class="formation">{{ $formationName }}</div>
        </div>

        <p>Ce certificat lui est délivré pour en jouir avec </p>
        <p>les droits et prérogatives qui y sont attachés.</p>

        <div class="footer">
            <p>+223 20 24 26 72 <span class="hidden">$$$$$$$$$$$$$$$$$$</span> contact@doucsoft.tech <span
                    class="hidden">$$$$$$$$$$$$$$$$$$</span> www.doucsoft.tech</p>
            <p>Sotuba ACI, Près de Japan Motors, Route de Koulikoro, Imm Wafa Simpara</p>
        </div>
    </div>
</body>

</html>
