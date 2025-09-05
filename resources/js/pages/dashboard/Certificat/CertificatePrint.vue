<script setup>
const props = defineProps({
    etudiant: Object,
    formation: Object,
});

const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: 'long',
        year: 'numeric',
    });
};

const printCertificate = () => {
    window.print();
};
</script>

<template>
    <div id="printable-content" class="certificate-container">
        <button @click="printCertificate" class="print-btn">🖨️ Imprimer</button>

        <div class="border">
            <br /><br />
            <div class="header">
                <img src="/asset/img/logo_formaplus.png" class="left" />
                <img src="/asset/img/hat.png" class="right" />
            </div>

            <hr />

            <div class="content">
                <h1>CERTIFICAT DE FORMATION QUALIFIANTE</h1>
                <p>La Direction du centre de formation <span class="blue">Forma+</span> certifie que:</p>

                <div class="name">MME/MR {{ etudiant.nom }} {{ etudiant.prenom }}</div>

                <p>
                    A suivi du <span class="red">{{ formatDate(formation.start_date) }}</span> au
                    <span class="red">{{ formatDate(formation.end_date) }}</span> la formation profil
                </p>
                <br />
                <div class="formation">{{ formation.title }}</div>
            </div>

            <div class="certificate-info-container">
                <div class="certificate-info">
                    <div class="certificate-logo">
                        <img :src="'/storage/' + formation.logo_formation" alt="Logo Formation" />
                    </div>
                    <div class="certificate-text">
                        <p>Ce certificat lui est délivré pour en jouir avec</p>
                        <br />
                        <p>les droits et prérogatives qui y sont attachés.</p>
                    </div>
                </div>
            </div>

            <div class="footer">
                <p>+223 20 24 26 72 | contact@doucsoft.tech | www.doucsoft.tech</p>
                <br />
                <p>Sotuba ACI, Près de Japan Motors, Route de Koulikoro, Imm Wafa Simpara</p>
            </div>
        </div>
    </div>
</template>

<style scoped>
/* Styles normaux (écran) */
.certificate-container {
    font-family: 'poppins', DejaVu Sans, sans-serif;
    text-align: center;
    position: relative;
    height: 100vh;
}

.print-btn {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1000;
    background: #3333ff;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-family: 'Baloo 2', sans-serif;
}

.print-btn:hover {
    background: #2525cc;
}

.border {
    padding: 40px;
    box-sizing: border-box;
    min-height: 100vh;
    position: relative;
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 40px;
    margin-bottom: 10px;
    padding-bottom: 70px;
}

.header img {
    height: 170px;
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
    margin-top: 30px;
    border-bottom: 3px solid #3333ff;
    padding-bottom: 30px;
    font-size: 16px;
    flex-grow: 1;
}

h1 {
    font-size: 24px;
    margin: 30px 0;
    font-weight: bold;
}

.name {
    background: #3333ff;
    color: white;
    font-size: 60px;
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
    width: 100%;
    font-size: 14px;
    font-weight: bold;
    padding: 20px 0;
    margin-top: auto;
    line-height: 1.2;
}

.hidden {
    visibility: hidden;
}

/* NOUVEAU: Conteneur principal pour centrer */
.certificate-info-container {
    display: flex;
    justify-content: center;
    width: 100%;
    margin: 10px 0;
}

.certificate-info {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 80px; /* Espacement entre logo et texte */
    max-width: 1000px;
    margin: 0 auto;
    padding: 0 20px;
}

.certificate-logo {
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
}

.certificate-logo img {
    width: 300px;
    height: 90px;
    object-fit: contain;
}

.certificate-text {
    text-align: center;
    font-size: 16px;
    line-height: 1.4;
    flex: 1;
    max-width: 500px;
}

/* Styles d'impression SEULEMENT */
@media print {
    @page {
        size: landscape;
        margin: 0;
    }

    body, html {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
    }

    .print-btn {
        display: none;
    }

    .certificate-container {
        width: 100vw;
        height: 100vh;
        margin: 0;
        padding: 0;
    }

    .border {
        width: 100vw;
        height: 100vh;
        padding: 30px;
        margin: 0;
    }

    /* Ajustements pour le mode paysage */
    .header {
        margin-top: 30px;
    }

    .header img {
        height: 150px;
    }

    .name {
        font-size: 40px;
        padding: 20px 10px;
        margin: 15px 0;
    }

    h1 {
        font-size: 25px;
        margin: 20px 0;
        font-weight: bold;
    }

    .formation {
        font-size: 25px;
    }

    .footer {
        font-size: 12px;
        padding: 15px 0;
    }

    /* Ajustement pour la section logo + texte */
    .certificate-info {
        gap: 40px;
        margin: 5px auto;
    }

    .certificate-logo img {
        width: 150px;
        height: 70px;
    }

    .certificate-text {
        font-size: 14px;
    }

    /* Force la visibilité de tous les éléments */
    * {
        visibility: visible !important;
    }

    /* Assure que les images s'impriment */
    img {
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
    }

    /* Couleurs d'impression */
    .name, .footer {
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
        background: #3333ff !important;
        color: white !important;
    }

    .blue, .formation {
        color: #3333ff !important;
    }

    .red {
        color: red !important;
    }

    .hidden {
        visibility: hidden;
    }
}
</style>
