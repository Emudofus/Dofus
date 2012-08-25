// Action script...

// [Initial MovieClip Action of sprite 20723]
#initclip 244
if (!dofus.DofusLoader)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    var _loc1 = (_global.dofus.DofusLoader = function ()
    {
        super();
        ank.utils.Extensions.addExtensions();
        this.initLoader(_root);
    }).prototype;
    (_global.dofus.DofusLoader = function ()
    {
        super();
        ank.utils.Extensions.addExtensions();
        this.initLoader(_root);
    }).main = function (mcRoot)
    {
        System.security.allowDomain("*");
        getURL("FSCommand:" add "trapallkeys", "true");
        getURL("FSCommand:" add "CustomerStart", "");
        _root = mcRoot;
        dofus.DofusLoader.registerAllClasses();
        _root._quality = "HIGH";
        _root.attachMovie("DofusLoader", "_loader", _root.getNextHighestDepth());
        _root.attachMovie("LoaderBorder", "_loaderBorder", _root.getNextHighestDepth(), {_x: -2, _y: -2});
        _root.createEmptyMovieClip("_misc", _root.getNextHighestDepth());
    };
    _loc1.initLoader = function (mcRoot)
    {
        this._sPrefixURL = this._url.substr(0, this._url.lastIndexOf("/") + 1);
        _global.CONFIG = new dofus.utils.DofusConfiguration();
        this.clearlogs();
        this.showBanner(true);
        this.showMainLogger(false);
        this.showShowLogsButton(false);
        this.showConfigurationChoice(false);
        this.showNextButton(false);
        this.showContinueButton(false);
        this.showClearCacheButton(false);
        this.showCopyLogsButton(false);
        this.showProgressBar(false);
        this._mcContainer = this.createEmptyMovieClip("__ANKDATA__", this.getNextHighestDepth());
        this._mcLocalFileList = this.createEmptyMovieClip("__ANKFILEDATA__", this.getNextHighestDepth());
        _global.CONFIG.isNewAccount = _root.htmlLogin != undefined && (_root.htmlPassword != undefined && (_root.htmlLogin != null && (_root.htmlPassword != null && (_root.htmlLogin != "null" && (_root.htmlPassword != "null" && (_root.htmlLogin != "" && _root.htmlPassword != ""))))));
        this._bNonCriticalError = false;
        this._bUpdate = false;
        this._sStep = null;
        ank.gapi.styles.StylesManager.loadStylePackage(ank.gapi.styles.DefaultStylePackage);
        ank.gapi.styles.StylesManager.loadStylePackage(dofus.graphics.gapi.styles.DofusStylePackage);
        ank.utils.Extensions.addExtensions();
        if (System.capabilities.playerType == "StandAlone")
        {
            Key.addListener(this);
        } // end if
        this._mcModules = mcRoot.createEmptyMovieClip("mcModules", mcRoot.getNextHighestDepth());
        this._mclLoader = new MovieClipLoader();
        this._mclLoader.addListener(this);
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initComponents});
        this.addToQueue({object: this, method: this.showBasicInformations, params: [true]});
    };
    _loc1.initComponents = function ()
    {
        this._lblConnexionServer.text = this.getText("SERVER");
        this._lblConfiguration.text = this.getText("CONFIGURATION");
        this._mcTotalProgressBarGroup.txtInfo.text = "Loading";
        this._btnChoose.label = this.getText("VALID");
        this._btnChoose.addEventListener("click", this);
        this._btnContinue.label = this.getText("CONTINUE");
        this._btnContinue.addEventListener("click", this);
        this._btnClearCache.label = this.getText("CLEAR_CACHE");
        this._btnClearCache.addEventListener("click", this);
        this._btnNext.label = this.getText("NEXT");
        this._btnNext.addEventListener("click", this);
        this._btnShowLogs.label = this.getText("SHOW_LOGS");
        this._btnShowLogs.addEventListener("click", this);
        this._btnCopyLogsToClipbard.label = this.getText("COPY_LOGS");
        this._btnCopyLogsToClipbard.addEventListener("click", this);
        this._lstConfiguration.addEventListener("itemSelected", this);
        this._lstConnexionServer.addEventListener("itemSelected", this);
        this.launchBannerAnim(true);
    };
    _loc1.initTexts = function ()
    {
        this.LANG_TEXT = new Object();
        this.LANG_TEXT.STARTING = {fr: "Initialisation de DOFUS...", en: "Initializing DOFUS...", es: "Inicializando DOFUS...", de: "Initialisierung von DOFUS im Gange...", pt: "Inicializando DOFUS...", nl: "DOFUS initialiseren...", it: "Inizializzazione DOFUS..."};
        this.LANG_TEXT.SERVER = {fr: "Serveur", en: "Server", es: "Servidor", de: "Server", pt: "Servidor", nl: "Server", it: "Server"};
        this.LANG_TEXT.CONFIGURATION = {fr: "Configuration", en: "Configuration", es: "Configuración", de: "Konfiguration", pt: "Configuração", nl: "Configuratie", it: "Configurazione"};
        this.LANG_TEXT.NEXT = {fr: "Continuer", en: "Next", es: "Siguiente", de: "Weiter", pt: "Próximo", nl: "Volgende", it: "Continuare"};
        this.LANG_TEXT.INIT_END = {fr: "Initialisation terminée", en: "Initialization completed", es: "Inicialización terminada", de: "Initialisierung beendet", pt: "Inicialização completada", nl: "Initialiseren voltooid", it: "Inizializzazzione terminata"};
        this.LANG_TEXT.VALID = {fr: "OK", en: "OK", es: "OK", de: "OK", pt: "OK", nl: "OK", it: "OK"};
        this.LANG_TEXT.CLEAR_CACHE = {fr: "Vider le cache", en: "Empty cache memory", es: "Vacía el caché ", de: "Den Cache leeren", pt: "Esvaziar memória cache", nl: "Cache geheugen legen", it: "Svuotare la cache"};
        this.LANG_TEXT.COPY_LOGS = {fr: "Copier les logs", en: "Copy logs", es: "Copiar logs", de: "Logs kopieren", pt: "Copiar logs", nl: "Logs kopiëren", it: "Copiare i log"};
        this.LANG_TEXT.SHOW_LOGS = {fr: "Afficher les logs", en: "Display logs", es: "Mostrar logs", de: "Logs anzeigen", pt: "Exibir logs", nl: "Laat de logs zien", it: "Visualizzare i log"};
        this.LANG_TEXT.CONTINUE = {fr: "Continuer", en: "Continue", es: "Continuar", de: "Fortfahren", pt: "Continuar", nl: "Volgende", it: "Continuare"};
        this.LANG_TEXT.ERROR = {fr: "Erreur", en: "Error", es: "Error", de: "Fehler", pt: "Erro", nl: "Fout", it: "Errore"};
        this.LANG_TEXT.WARNING = {fr: "Attention", en: "Warning", es: "Atención", de: "Warnung", pt: "Aviso", nl: "Waarschuwing", it: "Attenzione"};
        this.LANG_TEXT.DEBUG_MODE = {fr: "Mode debug activé ", en: "Debug mode activated", es: "Modo debug activado", de: "Debug Modus aktiviert", pt: "Modo de depuração ativado", nl: "Debug modus geactiveerd", it: "Modalità debug attiva"};
        this.LANG_TEXT.UNKNOWN_TYPE_NODE = {fr: "Paramètre inconnu", en: "Unknown parameter", es: "Parámetro desconocido", de: "Unbekannte Parameter", pt: "Parâmetro desconhecido", nl: "Onbekende parameter", it: "Parametro sconosciuto"};
        this.LANG_TEXT.LINK_HELP = {fr: "Cliquez ici pour voir les solutions", en: "Click here to see the solutions", es: "Pincha aquí para ver las soluciones", de: "Hier klicken für Lösungsvorschläge", pt: "Clique aqui para ver as soluções", nl: "Klik hier voor de oplossingen", it: "Clicca qui per vedere le soluzioni"};
        this.LANG_TEXT.LOADING_CONFIG_FILE = {fr: "Chargement du fichier de configuration...", en: "Configuration file downloading...", es: "Descargando el archivo de configuración", de: "Download der Konfigurationsdatei...", pt: "Baixando arquivo de configuração...", nl: "Configuratie bestand aan het downloaden...", it: "Caricamento del file di configurazione..."};
        this.LANG_TEXT.CONFIG_FILE_LOADED = {fr: "Fichier de configuration chargé ", en: "Configuration file downloaded", es: "Archivo de configuración descargado", de: "Download der Konfigurationsdatei beendet", pt: "Arquivo de configuração baixado", nl: "Configuratie bestand gedownload", it: "File di configurazione caricato"};
        this.LANG_TEXT.CHOOSE_CONFIGURATION = {fr: "Choix de la configuration...", en: "Configuration choice...", es: "Elección de la configuración...", de: "Auswahl der Konfiguration...", pt: "Escolha de configuração...", nl: "Configuratie keuze...", it: "Scelta della configurazione..."};
        this.LANG_TEXT.LOAD_MODULES = {fr: "Chargement des modules de jeu...", en: "Game modules loading...", es: "Descargando módulos del juego...", de: "Spielmodule werden geladen...", pt: "Carregando módulos de jogo...", nl: "Spel modules aan het laden...", it: "Caricamento dei moduli di gioco..."};
        this.LANG_TEXT.CURRENT_CONFIG = {fr: "Configuration choisie : <b>%1</b>", en: "Chosen Configuration : <b>%1</b>", es: "Configuración elegida: <b>%1</b>", de: "Ausgewählte Konfiguration: <b>%1</b>", pt: "Configuração escolhida : <b>%1</b>", nl: "Gekozen Configuratie : <b>%1</b>", it: "Configurazione scelta : <b>%1</b>"};
        this.LANG_TEXT.CURRENT_SERVER = {fr: "Server de connexion choisi : <b>%1</b>", en: "Chosen Connection Server : <b>%1</b>", es: "Servidor de conexión seleccionado: <b>%1</b>", de: "Ausgewählter Einwahlserver: <b>%1</b>", pt: "Conexão com o servidor escolhida : <b>%1</b>", nl: "Gekozen Verbindings Server : <b>%1</b>", it: "Server di connessione scelto : <b>%1</b>"};
        this.LANG_TEXT.LOAD_LANG_FILE = {fr: "Chargement du fichier de langue...", en: "Language file downloading...", es: "Descargando el archivo de idioma...", de: "Laden der Sprachdateien im Gange...", pt: "Baixando arquivo de idioma...", nl: "Taalbestand aan het downloaden...", it: "Caricamento del file di lingua..."};
        this.LANG_TEXT.CURRENT_LANG_FILE_VERSION = {fr: "Version du fichier de langue en local : <b>%1</b>", en: "Local version of the language file : <b>%1</b>", es: "Versión local del archivo de idioma: <b>%1</b>", de: "Lokale Version der Sprachdatei: <b>%1</b>", pt: "Versão locais do arquivo de idioma : <b>%1</b>", nl: "Locale versie van het taalbestand : <b>%1</b>", it: "Versione del file di lingua in rete locale : <b>%1</b>"};
        this.LANG_TEXT.CHECK_LAST_VERSION = {fr: "Verification des mises à jour...", en: "Checking updates...", es: "Comprobando actualizaciones...", de: "Suchen nach Updates...", pt: "Verificando atualizações...", nl: "Zoeken naar updates...", it: "Verifica degli aggiornamenti..."};
        this.LANG_TEXT.NEW_LANG_FILE_AVAILABLE = {fr: "Mise à jour disponible, téléchargement en cours de la version <b>%1</b>", en: "Update available. Version <b>%1</b> downloading...", es: "Actualización disponible. Descargando versión <b>%1</b>...", de: "Update gefunden. Download von Version <b>%1</b> im Gange...", pt: "Atualização disponível. Baixando versão <b>%1</b>...", nl: "Update beschikbaar/ Versie <b>%1</b> aan het downloaden...", it: "Aggiornamenti disponibili, download della versione in corso <b>%1</b>..."};
        this.LANG_TEXT.NO_NEW_VERSION_AVAILABLE = {fr: "Aucune mise à jour disponible", en: "No update available", es: "Ninguna actualización disponible", de: "Kein Update verfügbar", pt: "Não há atualização disponível", nl: "Geen update beschikbaar", it: "Nessun aggiornamento disponibile"};
        this.LANG_TEXT.IMPOSSIBLE_TO_JOIN_SERVER = {fr: "Impossible de joindre le serveur <b>%1</b>", en: "Server <b>%1</b> can not be reached", es: "Imposible conectar con el servidor <b>%1</b>", de: "Server <b>%1</b> unerreichbar", pt: "Servidor <b>%1</b> não pôde ser alcançado", nl: "Server <b>%1</b> kon niet bereikt worden", it: "Non è possibile collegarsi al server <b>%1</b>"};
        this.LANG_TEXT.LOAD_XTRA_FILES = {fr: "Chargement des fichiers de langue supplémentaires...", en: "Additional language files downloading...", es: "Descargando archivos de idioma adicionales...", de: "Download zusätzlicher Sprachdateien im Gange...", pt: "Baixando arquivos adicionais de idioma...", nl: "Additioneel taalbestand aan het downloaden...", it: "Caricamento del file di lingua supplementari..."};
        this.LANG_TEXT.UPDATE_FILE = {fr: "Mise à jour du fichier <b>%1</b>...", en: "Updating file <b>%1</b>...", es: "Actualizando el archivo <b>%1</b>...", de: "Update der Datei <b>%1</b> im Gange...", pt: "Atualizando arquivo <b>%1</b>...", nl: "Bestand <b>%1</b> aan het updaten...", it: "Aggiornamento del file <b>%1</b>..."};
        this.LANG_TEXT.NO_FILE_IN_LOCAL = {fr: "Fichier <b>%1</b> non présent dans le dossier local <b>%2</b>", en: "File <b>%1</b> can not be found in local folder <b>%2</b>", es: "No se consiguió encontrar el archivo <b>%1</b> en la carpeta <b>%2</b>", de: "Datei <b>%1</b> gefindet sich nicht im lokalen Ordner <b>%2</b>", pt: "Arquivo <b>%1</b> não pôde ser encontrado na pasta local <b>%2</b>", nl: "Bestand <b>%1</b> kan niet in de lokale folder <b>%2</b> worden gevonden", it: "File <b>%1</b>  non presente nella cartella locale <b>%2</b>"};
        this.LANG_TEXT.IMPOSSIBLE_TO_DOWNLOAD_FILE = {fr: "Impossible de télécharger le fichier <b>%1</b> a partir du serveur <b>%2</b>", en: "File <b>%1</b> can not be downloaded from server <b>%2</b>", es: "Ha sido imposible descargar el archivo <b>%1</b> desde el servidor <b>%2</b>", de: "Download der Datei <b>%1</b> vom Server <b>%2</b> fehlgeschlagen", pt: "Arquivo <b>%1</b> não foi baixando do servidor <b>%2</b>", nl: "Bestand <b>%1</b> kan niet van server <b>%2</b> worden gedownload", it: "Non è possibile scaricare il file <b>%1</b> dal server <b>%2</b>"};
        this.LANG_TEXT.UPDATE_FINISH = {fr: "Mise à jour du fichier <b>%1</b> terminée à partir du serveur <b>%2</b>", en: "Update of file <b>%1</b> from server <b>%2</b> completed", es: "Actualización del archivo <b>%1</b> a partir del servidor <b>%2</b>terminada", de: "Update der Datei <b>%1</b> vom Server <b>%2</b> abgeschlossen", pt: "Atualização do arquivo <b>%1</b> do servidor <b>%2</b> completada", nl: "Update van het bestand <b>%1</b> van server <b>%2</b> is voltooid", it: "Aggiornamento del file <b>%1</b>dal server terminato <b>%2</b>"};
        this.LANG_TEXT.MODULE_LOADED = {fr: "Module <b>%1</b> chargé ", en: "Module <b>%1</b> downloaded", es: "Módulo <b>%1</b> descargado", de: "Download von Modul <b>%1</b> abgeschlossen", pt: "Módulo <b>%1</b> baixado", nl: "Module <b>%1</b> gedownload", it: "Modulo <b>%1</b> caricato"};
        this.LANG_TEXT.FILE_LOADED = {fr: "Chargement du fichier <b>%1</b> terminé à partir du dossier local <b>%2</b>", en: "File <b>%1</b> from local folder <b>%2</b> downloaded", es: "Archivo <b>%1</b> de la carpeta <b>%2</b> descargado", de: "Download der Datei <b>%1</b> vom lokalen Ordner <b>%2</b> abgeschlossen", pt: "Arquivo <b>%1</b> da pasta local <b>%2</b> baixado", nl: "Bestand <b>%1</b> uit de lokale folder <b>%2</b> is gedownload", it: "Caricamento del file <b>%1</b> dalla cartella locale terminato <b>%2</b>"};
        this.LANG_TEXT.CORRUPT_FILE = {fr: "Fichier <b>%1</b> corrompu téléchargé à partir du serveur <b>%2</b> (Taille : %3)", en: "File <b>%1</b> corrupted. Downloaded from server <b>%2</b> (Size: %3)", es: "El archivo <b>%1</b> está corrupto. Descargado desde el servidor <b>%2</b> (Tamaño: %3)", de: "Datei <b>%1</b> ist korrupt. Heruntergeladen vom Server <b>%2</b> (Größe: %3)", pt: "Arquivo <b>%1</b> corrompido. Baixado do servidor <b>%2</b> (Tamanho: %3)", nl: "Bestand <b>%1</b> is beschadigd. Download van server <b>%2</b> (Grootte: %3)", it: "File <b>%1</b> corrotto scaricato dal server <b>%2</b> (Taglia: %3)"};
        this.ERRORS = new Object();
        var _loc2 = new Object();
        this.ERRORS.TOO_MANY_OCCURENCES = _loc2;
        _loc2.fr = "Vous ne pouvez pas lancer plus de clients DOFUS sur cet ordinateur.";
        _loc2.en = "You can\'t start anymore DOFUS client on this computer.";
        _loc2.es = "No puedes abrir más clientes DOFUS en este ordenador.";
        _loc2.de = "Es kann kein weiterer DOFUS-Client auf diesem Computer gestartet werden.";
        _loc2.pt = "Você não pode começar o cliente de DOFUS de novo neste computador.";
        _loc2.nl = "Je kan de DOFUS client niet meer op deze computer opstarten.";
        _loc2.it = "Non puoi lanciare più client su questo computer.";
        _loc2.linkfr = "http://www.dofus.com";
        _loc2.linken = "http://www.dofus.com";
        _loc2.linkes = "http://www.dofus.com";
        _loc2.linkde = "http://www.dofus.com";
        _loc2.linkpt = "http://www.dofus.com";
        _loc2.linknl = "http://www.dofus.com";
        _loc2.linkit = "http://www.dofus.com";
        _loc2 = new Object();
        this.ERRORS.BAD_FLASH_PLAYER = _loc2;
        _loc2.fr = "Vous devez posséder le lecteur Flash Player version 8 ou supérieure. (Version actuelle : " + System.capabilities.version + ")";
        _loc2.en = "You have to install the Flash Player version 8 or higher. (Actual version : " + System.capabilities.version + ")";
        _loc2.es = "Debes instalar el reproductor Flash Player versión 8 o superior. (Versión actual: " + System.capabilities.version + ")";
        _loc2.de = "Es wird die Version 8 oder höher des Flash Players benötigt. (Aktuelle Version: " + System.capabilities.version + ")";
        _loc2.pt = "Você precisa instalar a versão 8 ou superior do Flash Player. (Versão atual : " + System.capabilities.version + ")";
        _loc2.nl = "Je moet Flash Player versie 8 of hoger installeren. (Huidige versie : " + System.capabilities.version + ")";
        _loc2.it = "Devi avere il lettore Flash Player versione 8 o avanzata (Versione attuale:" + System.capabilities.version + ")";
        _loc2.linkfr = "http://store.adobe.com/go/getflashplayer";
        _loc2.linken = "http://store.adobe.com/go/getflashplayer";
        _loc2.linkes = "http://store.adobe.com/go/getflashplayer";
        _loc2.linkde = "http://store.adobe.com/go/getflashplayer";
        _loc2.linkpt = "http://store.adobe.com/go/getflashplayer";
        _loc2.linknl = "http://store.adobe.com/go/getflashplayer";
        _loc2.linkit = "http://store.adobe.com/go/getflashplayer";
        _loc2 = new Object();
        this.ERRORS.BAD_FLASH_SANDBOX = _loc2;
        _loc2.fr = "Les paramètres de sécurité actuels du lecteur Flash ne permettent pas à DOFUS de s\'executer.";
        _loc2.en = "You must configure DOFUS as a trusted application on the Flash Player security settings.";
        _loc2.es = "Los parámetros de seguridad actuales del reproductor Flash no permiten la ejecución de DOFUS.";
        _loc2.de = "DOFUS muss als vertrauenswürdige Anwendung in den Sicherheitseinstellungen des Flash Players konfiguriert werden.";
        _loc2.pt = "Você deve configurar DOFUS como uma aplicação confiável nas configurações de segurança do Flash Player.";
        _loc2.nl = "Je zult DOFUS als een veilige aplicatie moeten instellen bij de beveiligings instellingen van je Flash Player.";
        _loc2.it = "I parametri di sicurezza attuali del lettore Flash non permettono l\'esecuzione di DOFUS.";
        _loc2.linkfr = "http://support.ankama.com/fr/faq/198-comment-parametrer-flash-dofus";
        _loc2.linken = "http://support.ankama.com/en/faq/198-how-do-i-adapt-my-flash-settings-dofus";
        _loc2.linkes = "http://support.ankama.com/en/faq/198-how-do-i-adapt-my-flash-settings-dofus";
        _loc2.linkde = "http://support.ankama.com/de/faq/198-kann-flash-dofus-einstellen";
        _loc2.linkpt = "http://support.ankama.com/en/faq/198-how-do-i-adapt-my-flash-settings-dofus";
        _loc2.linknl = "http://support.ankama.com/en/faq/198-how-do-i-adapt-my-flash-settings-dofus";
        _loc2.linkit = "http://support.ankama.com/en/faq/198-how-do-i-adapt-my-flash-settings-dofus";
        _loc2 = new Object();
        this.ERRORS.UPDATE_LANG_IMPOSSIBLE = _loc2;
        _loc2.fr = "Impossible de charger le fichier de langue";
        _loc2.en = "Impossible to download the language file";
        _loc2.es = "Descarga del archivo de idioma imposible";
        _loc2.de = "Download der Sprachdatei nicht möglich";
        _loc2.pt = "Impossível baixar o arquivo de idioma";
        _loc2.nl = "Onmogelijk om dit taalbestand te downloaden";
        _loc2.it = "Non è possibile caricare il file di lingua";
        _loc2.linkfr = "http://support.ankama.com/fr/faq/160-erreur-impossible-mettre-jour-fichier";
        _loc2.linken = "http://support.ankama.com/en/faq/160-error-cannot-update-file";
        _loc2.linkes = "http://support.ankama.com/en/faq/160-error-cannot-update-file";
        _loc2.linkde = "http://support.ankama.com/de/faq/160-fehlermeldung-update-sprachdatei-nicht-moeglich";
        _loc2.linkpt = "http://support.ankama.com/en/faq/160-error-cannot-update-file";
        _loc2.linknl = "http://support.ankama.com/en/faq/160-error-cannot-update-file";
        _loc2.linkit = "http://support.ankama.com/en/faq/160-error-cannot-update-file";
        _loc2 = new Object();
        this.ERRORS.NO_CONFIG_FILE = _loc2;
        _loc2.fr = "Impossible de charger le fichier de configuration";
        _loc2.en = "Impossible to load the configuration file";
        _loc2.es = "No se puede cargar el archivo de configuración";
        _loc2.de = "Laden der Konfigurationsdatei nicht möglich";
        _loc2.pt = "Impossível carregar o arquivo de configuração";
        _loc2.nl = "Onmogelijk om het configuratie bestand te laden";
        _loc2.it = "Non è possibile caricare il file di configurazione";
        _loc2.linkfr = "http://support.ankama.com/fr/faq/772";
        _loc2.linken = "http://support.ankama.com/en/faq/772";
        _loc2.linkes = "http://support.ankama.com/es/faq/772";
        _loc2.linkde = "http://support.ankama.com/de/faq/772";
        _loc2.linkpt = "http://support.ankama.com/en/faq/772";
        _loc2.linknl = "http://support.ankama.com/en/faq/772";
        _loc2.linkit = "http://support.ankama.com/en/faq/772";
        _loc2 = new Object();
        this.ERRORS.CORRUPT_CONFIG_FILE = _loc2;
        _loc2.fr = "Impossible de lire le fichier de configuration";
        _loc2.en = "Impossible to read the configuration file";
        _loc2.es = "No es posible leer el archivo de configuración";
        _loc2.de = "Unmöglich die Konfigurationsdatei zu lesen";
        _loc2.pt = "Impossível ler o arquivo de configuração";
        _loc2.nl = "Onmogelijk om het configuratie bestand te lezen";
        _loc2.it = "Non è possibile leggere il file di configurazione";
        _loc2.linkfr = "http://support.ankama.com/fr/faq/773";
        _loc2.linken = "http://support.ankama.com/en/faq/773";
        _loc2.linkes = "http://support.ankama.com/es/faq/773";
        _loc2.linkde = "http://support.ankama.com/de/faq/773";
        _loc2.linkpt = "http://support.ankama.com/en/faq/773";
        _loc2.linknl = "http://support.ankama.com/en/faq/773";
        _loc2.linkit = "http://support.ankama.com/en/faq/773";
        _loc2 = new Object();
        this.ERRORS.CHECK_LAST_VERSION_FAILED = _loc2;
        _loc2.fr = "Impossible de vérifier les mises à jour";
        _loc2.en = "Impossible to check updates";
        _loc2.es = "No es posible comprobar las actualizacones";
        _loc2.de = "Updateprüfung nicht möglich";
        _loc2.pt = "Impossível verificar atualizações";
        _loc2.nl = "Onmogelijk om op updates te controleren";
        _loc2.it = "Non è possibile verificare gli aggiornamenti";
        _loc2.linkfr = "http://support.ankama.com/fr/faq/188-erreur-impossible-verifier-mises-jour";
        _loc2.linken = "http://support.ankama.com/en/faq/188-error-cannot-verify-updates";
        _loc2.linkes = "http://support.ankama.com/en/faq/188-error-cannot-verify-updates";
        _loc2.linkde = "http://support.ankama.com/de/faq/188-fehlermeldung-update-nicht-ueberpruefbar";
        _loc2.linkpt = "http://support.ankama.com/en/faq/188-error-cannot-verify-updates";
        _loc2.linknl = "http://support.ankama.com/en/faq/188-error-cannot-verify-updates";
        _loc2.linkit = "http://support.ankama.com/en/faq/188-error-cannot-verify-updates";
        _loc2 = new Object();
        this.ERRORS.IMPOSSIBLE_TO_LOAD_MODULE = _loc2;
        _loc2.fr = "Impossible de charger le module <b>%1</b>";
        _loc2.en = "Impossible to download the module <b>%1</b>";
        _loc2.es = "No es posible descargar el módulo <b>%1</b>";
        _loc2.de = "Download des Moduls  <b>%1</b> nicht möglich";
        _loc2.pt = "Impossível baixar o módulo <b>%1</b>";
        _loc2.nl = "Onmogelijk om module <b>%1</b> te downloaden";
        _loc2.it = "Non è possibile caricare il modulo <b>%1</b>";
        _loc2.linkfr = "http://support.ankama.com/fr/faq/771";
        _loc2.linken = "http://support.ankama.com/en/faq/771";
        _loc2.linkes = "http://support.ankama.com/es/faq/771";
        _loc2.linkde = "http://support.ankama.com/de/faq/771";
        _loc2.linkpt = "http://support.ankama.com/en/faq/771";
        _loc2.linknl = "http://support.ankama.com/en/faq/771";
        _loc2.linkit = "http://support.ankama.com/en/faq/771";
        _loc2 = new Object();
        this.ERRORS.WRITE_FAILED = _loc2;
        _loc2.fr = "Impossible de sauvegarder le fichier <b>%1</b> en local";
        _loc2.en = "Impossible to save file <b>%1</b> in local";
        _loc2.es = "No es posible guardar el archivo <b>%1</b> en local";
        _loc2.de = "Lokales Speichern der Datei <b>%1</b> nicht möglich";
        _loc2.pt = "Impossível salvar o arquivo <b>%1</b> localmente";
        _loc2.nl = "Onmogelijk het bestand <b>%1</b> lokaal te bewaren";
        _loc2.it = "Non è possibile registrare il file <b>%1</b> su rete locale";
        _loc2.linkfr = "http://support.ankama.com/fr/faq/175-erreur-impossible-sauvegarder-fichier-local";
        _loc2.linken = "http://support.ankama.com/en/faq/176-error-cannot-save-file-name-file-locally";
        _loc2.linkes = "http://support.ankama.com/en/faq/176-error-cannot-save-file-name-file-locally";
        _loc2.linkde = "http://support.ankama.com/de/faq/175-fehlermeldung-lokales-speichern-sprachdatei-nicht-moeglich";
        _loc2.linkpt = "http://support.ankama.com/en/faq/176-error-cannot-save-file-name-file-locally";
        _loc2.linknl = "http://support.ankama.com/en/faq/176-error-cannot-save-file-name-file-locally";
        _loc2.linkit = "http://support.ankama.com/en/faq/176-error-cannot-save-file-name-file-locally";
        _loc2 = new Object();
        this.ERRORS.CANT_UPDATE_FILE = _loc2;
        _loc2.fr = "Impossible de mettre a jour le fichier <b>%1</b>";
        _loc2.en = "Impossible to update file <b>%1</b>";
        _loc2.es = "No es posible actualizar el archivo <b>%1</b>";
        _loc2.de = "Update der Datei <b>%1</b> nicht möglich";
        _loc2.pt = "Impossível atualizar o arquivo <b>%1</b>";
        _loc2.nl = "Onmogelijk om het bestand <b>%1</b> te updaten";
        _loc2.it = "Non è possibile aggiornare il file <b>%1</b>";
        _loc2.linkfr = "http://support.ankama.com/fr/faq/161-erreur-impossible-mettre-jour-fichier-nom-fichier";
        _loc2.linken = "http://support.ankama.com/en/faq/161-error-cannot-update-file-name-file";
        _loc2.linkes = "http://support.ankama.com/en/faq/161-error-cannot-update-file-name-file";
        _loc2.linkde = "http://support.ankama.com/de/faq/176-fehlermeldung-lokales-speichern-dateinamen-nicht-moeglich";
        _loc2.linkpt = "http://support.ankama.com/en/faq/161-error-cannot-update-file-name-file";
        _loc2.linknl = "http://support.ankama.com/en/faq/161-error-cannot-update-file-name-file";
        _loc2.linkit = "http://support.ankama.com/en/faq/161-error-cannot-update-file-name-file";
    };
    (_global.dofus.DofusLoader = function ()
    {
        super();
        ank.utils.Extensions.addExtensions();
        this.initLoader(_root);
    }).registerAllClasses = function ()
    {
        Object.registerClass("ButtonNormalDown", ank.gapi.controls.button.ButtonBackground);
        Object.registerClass("ButtonNormalUp", ank.gapi.controls.button.ButtonBackground);
        Object.registerClass("ButtonToggleDown", ank.gapi.controls.button.ButtonBackground);
        Object.registerClass("ButtonToggleUp", ank.gapi.controls.button.ButtonBackground);
        Object.registerClass("ButtonSimpleRectangleUpDown", ank.gapi.controls.button.ButtonBackground);
        Object.registerClass("Label", ank.gapi.controls.Label);
        Object.registerClass("Button", ank.gapi.controls.Button);
        Object.registerClass("SelectableRow", ank.gapi.controls.list.SelectableRow);
        Object.registerClass("DefaultCellRenderer", ank.gapi.controls.list.DefaultCellRenderer);
        Object.registerClass("List", ank.gapi.controls.List);
        Object.registerClass("ConsoleLogger", ank.gapi.controls.ConsoleLogger);
        Object.registerClass("DofusLoader", dofus.DofusLoader);
        Object.registerClass("Loader", ank.gapi.controls.Loader);
    };
    _loc1.log = function (sText, sHColor, sLColor)
    {
        if (sHColor == undefined)
        {
            sHColor = "#CCCCCC";
        } // end if
        if (sLColor == undefined)
        {
            sLColor = "#666666";
        } // end if
        this._currentLogger.log(sText, sHColor, sLColor);
        this.addToSaveLog(sText);
    };
    _loc1.addToSaveLog = function (sText)
    {
        this._sLogs = this._sLogs + (new ank.utils.ExtendedString(sText).replace("&nbsp;", " ") + "\r\n");
    };
    _loc1.logTitle = function (sText)
    {
        this.log("");
        this.log(sText, "#CCCCCC", "#CCCCCC");
    };
    _loc1.logRed = function (sText)
    {
        this.log(sText, "#FF0000", "#DD0000");
    };
    _loc1.logGreen = function (sText)
    {
        this.log(sText, "#00FF00", "#00AA00");
    };
    _loc1.logOrange = function (sText)
    {
        this.log(sText, "#FF9900", "#DD7700");
    };
    _loc1.logYellow = function (sText)
    {
        this.log(sText, "#FFFF00", "#AAAA00");
    };
    _loc1.getText = function (key, aParams)
    {
        var _loc4 = this.LANG_TEXT[key][_global.CONFIG.language];
        if (_loc4 == undefined || _loc4.length == 0)
        {
            _loc4 = _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data[key];
        } // end if
        if (_loc4 == undefined || _loc4.length == 0)
        {
            _loc4 = this.LANG_TEXT[key].fr;
        } // end if
        return (this.replaceText(_loc4, aParams));
    };
    _loc1.replaceText = function (sText, aParams)
    {
        if (aParams == undefined)
        {
            aParams = new Array();
        } // end if
        var _loc4 = new Array();
        var _loc5 = new Array();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < aParams.length)
        {
            _loc4.push("%" + (_loc6 + 1));
            _loc5.push(aParams[_loc6]);
        } // end while
        return (new ank.utils.ExtendedString(sText).replace(_loc4, _loc5));
    };
    _loc1.clearlogs = function ()
    {
        this._cLogger.clear();
        this._cLoggerInit.clear();
        this._cLoggerError.clear();
    };
    _loc1.setProgressBarValue = function (nValue, nMax)
    {
        this.showProgressBar(true);
        if (nValue > nMax)
        {
            nValue = nMax;
        } // end if
        this._mcProgressBarGroup.mcProgressBar._width = nValue / nMax * 100;
        this._mcProgressBarGroup.txtPercent.text = Math.floor(Number(this._mcProgressBarGroup.mcProgressBar._width)) + "%";
    };
    _loc1.showProgressBar = function (bShow)
    {
        if (this._mcProgressBarGroup._visible != bShow)
        {
            this._mcProgressBarGroup._visible = bShow;
        } // end if
    };
    _loc1.moveProgressBar = function (nX)
    {
    };
    _loc1.showWaitBar = function (bShow)
    {
        if (bShow)
        {
            this._mcWaitBar = this.attachMovie("GrayWaitBar", "_mcWaitBar", 1000, {_x: this._mcProgressBarGroup._x + this._mcProgressBarGroup.mcProgressBarBorder._x, _y: this._mcProgressBarGroup._y + this._mcProgressBarGroup.mcProgressBarBorder._y});
            this._mcWaitBar.txtInfo.text = "Waiting";
        }
        else
        {
            this._mcWaitBar.removeMovieClip();
        } // end else if
        if (bShow)
        {
            this.showProgressBar(false);
        } // end if
    };
    _loc1.setTotalBarValue = function (nValue, nMax)
    {
        this.showTotalBar(true);
        if (nValue > nMax)
        {
            nValue = nMax;
        } // end if
        this._mcTotalProgressBarGroup.mcProgressBar._width = nValue / nMax * 100;
        this._mcTotalProgressBarGroup.txtPercent.text = Math.floor(Number(this._mcTotalProgressBarGroup.mcProgressBar._width)) + "%";
    };
    _loc1.showTotalBar = function (bShow)
    {
        if (bShow)
        {
            var _loc3 = 10079232;
            var _loc4 = (_loc3 & 16711680) >> 16;
            var _loc5 = (_loc3 & 65280) >> 8;
            var _loc6 = _loc3 & 255;
            var _loc7 = new Color(this._mcTotalProgressBarGroup.mcProgressBar);
            var _loc8 = new Object();
            _loc8 = {ra: "0", rb: _loc4, ga: "0", gb: _loc5, ba: "0", bb: _loc6, aa: "100", ab: "0"};
            _loc7.setTransform(_loc8);
            this._mcLoadingWindow._visible = true;
            this._mcTotalProgressBarGroup._visible = true;
        }
        else
        {
            this._mcTotalProgressBarGroup._visible = false;
            this._mcLoadingWindow._visible = false;
        } // end else if
    };
    _loc1.showConfigurationChoice = function (bShow)
    {
        this._lblConfiguration._visible = bShow;
        this._lstConfiguration._visible = bShow;
        this._lblConnexionServer._visible = bShow;
        this._lstConnexionServer._visible = bShow;
        this._btnChoose._visible = bShow;
    };
    _loc1.showNextButton = function (bShow)
    {
        this._btnNext._visible = bShow;
    };
    _loc1.showShowLogsButton = function (bShow)
    {
        this._btnShowLogs._visible = bShow;
    };
    _loc1.showContinueButton = function (bShow)
    {
        this._btnContinue._visible = bShow;
    };
    _loc1.showClearCacheButton = function (bShow)
    {
        this._btnClearCache._visible = bShow;
    };
    _loc1.showCopyLogsButton = function (bShow)
    {
        this._btnCopyLogsToClipbard._visible = bShow;
    };
    _loc1.showMainLogger = function (bShow)
    {
        if (bShow == undefined)
        {
            bShow = !this._cLogger._visible;
        } // end if
        this._cLogger._visible = bShow;
    };
    _loc1.nonCriticalError = function (sError, sTab)
    {
        this.logOrange(sTab + "<b>" + this.getText("WARNING") + "</b> : " + sError);
        this._bNonCriticalError = true;
    };
    _loc1.criticalError = function (sError, sTab, bShowClearCacheButton, aParams, sFrom)
    {
        var _loc7 = this.ERRORS[sError];
        this.ERRORS.current = sError;
        this.ERRORS.from = sFrom;
        var _loc8 = this.replaceText(_loc7[_global.CONFIG.language], aParams);
        if (_loc8 == undefined || _loc8.length == 0)
        {
            _loc8 = this.replaceText(_loc7.fr, aParams);
        } // end if
        this._cLoggerError.log("<b>" + this.getText("ERROR") + "</b> : " + _loc8, "#FF0000", "#DD0000");
        var _loc9 = "<u><a href=\'" + _loc7["link" + _global.CONFIG.language] + "\' target=\'_blank\'>" + this.getText("LINK_HELP") + "</a></u>";
        this._cLoggerError.log(_loc9, "#FF0000", "#DD0000");
        this.addToSaveLog(sTab + "<b>" + this.getText("ERROR") + "</b> : " + _loc8);
        this.showCopyLogsButton(true);
        this.showShowLogsButton(true);
        this.showContinueButton(true);
        if (bShowClearCacheButton)
        {
            this.showClearCacheButton(true);
        } // end if
    };
    _loc1.getLangSharedObject = function ()
    {
        return (ank.utils.SharedObjectFix.getLocal(dofus.Constants.LANG_SHAREDOBJECT_NAME));
    };
    _loc1.getXtraSharedObject = function ()
    {
        return (ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME));
    };
    _loc1.getOptionsSharedObject = function ()
    {
        return (ank.utils.SharedObjectFix.getLocal(dofus.Constants.GLOBAL_SO_OPTIONS_NAME));
    };
    _loc1.getShortcutsSharedObject = function ()
    {
        return (ank.utils.SharedObjectFix.getLocal(dofus.Constants.GLOBAL_SO_SHORTCUTS_NAME));
    };
    _loc1.getOccurencesSharedObject = function ()
    {
        return (ank.utils.SharedObjectFix.getLocal(dofus.Constants.GLOBAL_SO_OCCURENCES_NAME));
    };
    _loc1.getCacheDateSharedObject = function ()
    {
        return (ank.utils.SharedObjectFix.getLocal(dofus.Constants.GLOBAL_SO_CACHEDATE_NAME));
    };
    _loc1.launchBannerAnim = function (bPlay)
    {
        if (!this._bBannerDisplay)
        {
            this.showBanner(true);
        } // end if
        if (bPlay)
        {
            this._mcBanner.playAll();
        }
        else
        {
            this._mcBanner.stopAll();
        } // end else if
    };
    _loc1.showBanner = function (bShow)
    {
        var _loc3 = bShow == undefined ? (!this._bBannerDisplay) : (bShow);
        if (_loc3)
        {
            if (this._bBannerDisplay)
            {
                return;
            } // end if
            var _loc5 = "";
            var _loc4 = this.attachMovie("LoadingBanner_" + _global.CONFIG.language, "_mcBanner", this.getNextHighestDepth(), this._mcBannerPlacer);
            if (!_loc4)
            {
                _loc4 = this.attachMovie("LoadingBanner_" + _loc5, "_mcBanner", this.getNextHighestDepth(), this._mcBannerPlacer);
            } // end if
            if (!_loc4)
            {
                _loc4 = this.attachMovie("LoadingBanner", "_mcBanner", this.getNextHighestDepth(), this._mcBannerPlacer);
            } // end if
            _loc4.cacheAsBitmap = true;
            _loc4.swapDepths(this._mcBannerPlacer);
        }
        else
        {
            if (!this._bBannerDisplay)
            {
                return;
            } // end if
            this._mcBanner.swapDepths(this._mcBannerPlacer);
            this._mcBanner.removeMovieClip();
        } // end else if
        this._bBannerDisplay = _loc3;
    };
    _loc1.copyAndOrganizeDataServerList = function ()
    {
        var _loc2 = _global.CONFIG.dataServers.slice(0);
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            var _loc4 = _loc2[_loc3];
            if (_loc4.nPriority == undefined || _global.isNaN(_loc4.nPriority))
            {
                _loc4.nPriority = 0;
            } // end if
            var _loc5 = _loc4.priority;
            _loc4.rand = random(99999);
        } // end while
        _loc2.sortOn(["priority", "rand"], Array.DESCENDING);
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc2.length)
        {
        } // end while
        return (_loc2);
    };
    _loc1.checkOccurences = function ()
    {
        var _loc2 = _global.API.lang.getConfigText("MAXIMUM_CLIENT_OCCURENCES");
        if (_loc2 == undefined || (_global.isNaN(_loc2) || _loc2 < 1))
        {
            return (true);
        } // end if
        var _loc3 = this.getOccurencesSharedObject().data.occ;
        var _loc4 = new Array();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            if (_loc3[_loc5].tick + dofus.Constants.MAX_OCCURENCE_DELAY > new Date().getTime())
            {
                _loc4.push(_loc3[_loc5]);
            } // end if
        } // end while
        var _loc6 = _loc4.length;
        if (!_global.API.datacenter.Player.isAuthorized && _loc6 + 1 > _loc2)
        {
            this.criticalError("TOO_MANY_OCCURENCES", this.TABULATION, false);
            return (false);
        } // end if
        this._nOccurenceId = Math.round(Math.random() * 1000);
        _loc4.push({id: this._nOccurenceId, tick: new Date().getTime()});
        this.getOccurencesSharedObject().data.occ = _loc4;
        _global.setInterval(this, "refreshOccurenceTick", dofus.Constants.OCCURENCE_REFRESH);
        return (true);
    };
    _loc1.refreshOccurenceTick = function ()
    {
        var _loc2 = this.getOccurencesSharedObject().data.occ;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < _loc2.length)
        {
            if (_loc2[_loc3].id == this._nOccurenceId)
            {
                _loc2[_loc3].tick = new Date().getTime();
                break;
            } // end if
        } // end while
        this.getOccurencesSharedObject().data.occ = _loc2;
    };
    _loc1.checkFlashPlayer = function ()
    {
        var _loc2 = System.capabilities.version;
        var _loc3 = Number(_loc2.split(" ")[1].split(",")[0]);
        var _loc4 = System.capabilities.playerType.length == 0 ? (" ") : (" (" + System.capabilities.playerType + ")");
        this.log(this.TABULATION + "Flash player" + _loc4 + " <b>" + _loc2 + "</b>");
        if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
        {
            this.getURL("JavaScript:WriteLog(\'checkFlashPlayer;" + _loc3 + "\')");
            this.getURL("JavaScript:WriteLog(\'buildVersion;" + dofus.Constants.BUILD_NUMBER + "\')");
        } // end if
        if (_loc3 >= 8)
        {
            var _loc5 = System.security.sandboxType;
            if (_loc5 != "localTrusted" && _loc5 != "remote")
            {
                this.criticalError("BAD_FLASH_SANDBOX", this.TABULATION, false);
                return (false);
            } // end if
            return (true);
        }
        else
        {
            this.criticalError("BAD_FLASH_PLAYER", this.TABULATION, false);
            this.showBanner(false);
            return (false);
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnChoose:
            {
                this.chooseConfiguration(this._lstConfiguration.selectedItem.data, this._lstConnexionServer.selectedItem.data, true);
                break;
            } 
            case this._btnClearCache:
            {
                this.clearCache();
                this.reboot();
                break;
            } 
            case this._btnCopyLogsToClipbard:
            {
                System.setClipboard(this._sLogs);
                break;
            } 
            case this._btnShowLogs:
            {
                this.showBanner(false);
                this.showMainLogger();
                break;
            } 
            case this._btnContinue:
            {
                switch (this.ERRORS.current)
                {
                    case "CHECK_LAST_VERSION_FAILED":
                    {
                        var _loc3 = new LoadVars();
                        _loc3.f = "";
                        this.onCheckLanguage(true, _loc3, "", "");
                        break;
                    } 
                    case "CHECK_LAST_VERSION_FAILED":
                    {
                        var _loc4 = new LoadVars();
                        _loc4.f = "";
                        this.onCheckLanguage(true, _loc4, "", "");
                        break;
                    } 
                } // End of switch
                break;
            } 
            case this._btnNext:
            {
                this.showNextButton(false);
                switch (this._sStep)
                {
                    case "MODULE":
                    {
                        this.initCore(_global.MODULE_CORE);
                        break;
                    } 
                    case "XTRA":
                    {
                        this.initAndLoginFinished();
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._lstConfiguration:
            {
                this.selectConfiguration();
                break;
            } 
            case this._lstConnexionServer:
            {
                this.selectConnexionServer();
                break;
            } 
        } // End of switch
    };
    _loc1.onKeyUp = function ()
    {
        if (Key.getCode() == Key.ESCAPE)
        {
            getURL("FSCommand:" add "quit", "");
        } // end if
    };
    _loc1.setDisplayStyle = function (sStyleName)
    {
        if (System.capabilities.playerType == "PlugIn" && !_global.CONFIG.isStreaming)
        {
            this.getURL("javascript:setFlashStyle(\'flashid\', \'" + sStyleName + "\');");
        } // end if
    };
    _loc1.closeBrowserWindow = function ()
    {
        if (System.capabilities.playerType == "PlugIn")
        {
            this.getURL("javascript:closeBrowserWindow();");
        } // end if
    };
    _loc1.reboot = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < dofus.Constants.MODULES_LIST.length)
        {
            this._mclLoader.unloadClip(_global["MODULE_" + dofus.Constants.MODULES_LIST[_loc2][4]]);
        } // end while
        this.initLoader(_root);
    };
    _loc1.clearCache = function ()
    {
        ank.utils.SharedObjectFix.getLocal(dofus.Constants.LANG_SHAREDOBJECT_NAME).clear();
        ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME).clear();
    };
    _loc1.showLoader = function (bShow, bNotClear)
    {
        this._visible = bShow;
    };
    _loc1.showBasicInformations = function (bContinue)
    {
        this._currentLogger = this._cLoggerInit;
        this.logTitle(this.getText("STARTING"));
        this.log(this.TABULATION + "Dofus version : <b>" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + "</b> " + (dofus.Constants.BETAVERSION > 0 ? ("(<font color=\"#FF0000\"><i><b>BETA " + dofus.Constants.BETAVERSION + "</b></i></font>) ") : ("")) + "(build " + dofus.Constants.BUILD_NUMBER + (dofus.Constants.ALPHA ? (" <font color=\"#00FF00\"><i><b>ALPHA BUILD</b></i></font>") : ("")) + ")");
        if (!this.checkFlashPlayer())
        {
            this.showShowLogsButton(false);
            this.showCopyLogsButton(false);
            return;
        } // end if
        this.checkCacheVersion();
        this._currentLogger = this._cLogger;
        if (bContinue)
        {
            this.addToQueue({object: this, method: this.loadConfig});
        } // end if
    };
    _loc1.loadConfig = function ()
    {
        this.showLoader(true);
        this.moveProgressBar(0);
        this.logTitle(this.getText("LOADING_CONFIG_FILE"));
        var _loc2 = new XML();
        var loader = this;
        _loc2.ignoreWhite = true;
        _loc2.onLoad = function (bSuccess)
        {
            loader.onConfigLoaded(bSuccess, this);
        };
        this.showWaitBar(true);
        _loc2.load(dofus.Constants.CONFIG_XML_FILE);
    };
    _loc1.onConfigLoaded = function (bSuccess, xDoc)
    {
        this.showWaitBar(false);
        if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
        {
            this.getURL("JavaScript:WriteLog(\'onConfigLoaded;" + bSuccess + "\')");
        } // end if
        if (bSuccess)
        {
            this.setTotalBarValue(50, 100);
            var _loc4 = xDoc.firstChild.firstChild;
            if (xDoc.childNodes.length == 0 || _loc4 == null)
            {
                this.criticalError("CORRUPT_CONFIG_FILE", this.TABULATION, false);
                return;
            } // end if
            _global.CONFIG.cacheAsBitmap = new Array();
            var _loc5 = new ank.utils.ExtendedArray();
            var _loc6 = false;
            while (_loc4 != null)
            {
                switch (_loc4.nodeName)
                {
                    case "delay":
                    {
                        _global.CONFIG.delay = _loc4.attributes.value;
                        break;
                    } 
                    case "rdelay":
                    {
                        _global.CONFIG.rdelay = _loc4.attributes.value;
                        break;
                    } 
                    case "rcount":
                    {
                        _global.CONFIG.rcount = _loc4.attributes.value;
                        break;
                    } 
                    case "hardcore":
                    {
                        _global.CONFIG.onlyHardcore = true;
                        break;
                    } 
                    case "streaming":
                    {
                        _global.CONFIG.isStreaming = true;
                        if (_loc4.attributes.method)
                        {
                            _global.CONFIG.streamingMethod = _loc4.attributes.method;
                        }
                        else
                        {
                            _global.CONFIG.streamingMethod = "compact";
                        } // end else if
                        _root._misc.attachMovie("UI_Misc", "miniClip", _root._misc.getNextHighestDepth());
                        break;
                    } 
                    case "expo":
                    {
                        _global.CONFIG.isExpo = true;
                        break;
                    } 
                    case "conf":
                    {
                        var _loc7 = _loc4.attributes.name;
                        var _loc8 = _loc4.attributes.type;
                        if (_loc7 != undefined && (dofus.Constants.TEST != true && _loc8 != "test" || dofus.Constants.TEST == true && _loc8 == "test"))
                        {
                            var _loc9 = new Object();
                            _loc9.name = _loc7;
                            _loc9.debug = _loc4.attributes.boo != undefined;
                            _loc9.connexionServers = new ank.utils.ExtendedArray();
                            _loc9.dataServers = new Array();
                            for (var _loc10 = _loc4.firstChild; _loc10 != null; _loc10 = _loc10.nextSibling)
                            {
                                switch (_loc10.nodeName)
                                {
                                    case "dataserver":
                                    {
                                        var _loc11 = _loc10.attributes.url;
                                        var _loc12 = _loc10.attributes.type;
                                        var _loc13 = Number(_loc10.attributes.priority);
                                        if (_loc11 != undefined && _loc11 != "")
                                        {
                                            _loc9.dataServers.push({url: _loc11, type: _loc12, priority: _loc13});
                                            System.security.allowDomain(_loc11);
                                        } // end if
                                        break;
                                    } 
                                    case "connserver":
                                    {
                                        var _loc14 = _loc10.attributes.name;
                                        var _loc15 = _loc10.attributes.ip;
                                        var _loc16 = _loc10.attributes.port;
                                        if (_loc14 != undefined && (_loc15 != "" && _loc16 != undefined))
                                        {
                                            _loc9.connexionServers.push({label: _loc14, data: {name: _loc14, ip: _loc15, port: _loc16}});
                                        } // end if
                                        break;
                                    } 
                                    default:
                                    {
                                        this.nonCriticalError(this.getText("UNKNOWN_TYPE_NODE") + " (" + _loc4.nodeName + ")", this.TABULATION);
                                        break;
                                    } 
                                } // End of switch
                            } // end of for
                            if (_loc9.dataServers.length > 0)
                            {
                                _loc5.push({label: _loc9.name, data: _loc9});
                            } // end if
                        } // end if
                        break;
                    } 
                    case "languages":
                    {
                        _global.CONFIG.xmlLanguages = _loc4.attributes.value.split(",");
                        _global.CONFIG.skipLanguageVerification = _loc4.attributes.skipcheck == "true" || _loc4.attributes.skipcheck == "1";
                        break;
                    } 
                    case "cacheasbitmap":
                    {
                        for (var _loc17 = _loc4.firstChild; _loc17 != null; _loc17 = _loc17.nextSibling)
                        {
                            var _loc18 = _loc17.attributes.element;
                            var _loc19 = _loc17.attributes.value == "true";
                            _global.CONFIG.cacheAsBitmap[_loc18] = _loc19;
                        } // end of for
                        break;
                    } 
                    case "servers":
                    {
                        var _loc20 = _loc4.firstChild;
                        _global.CONFIG.customServersIP = new Array();
                        while (_loc20 != null)
                        {
                            var _loc21 = _loc20.attributes.id;
                            var _loc22 = _loc20.attributes.ip;
                            var _loc23 = _loc20.attributes.port;
                            _global.CONFIG.customServersIP[_loc21] = {ip: _loc22, port: _loc23};
                            _loc20 = _loc20.nextSibling;
                        } // end while
                        break;
                    } 
                    default:
                    {
                        this.nonCriticalError(this.getText("UNKNOWN_TYPE_NODE") + " (" + _loc4.nodeName + ")", this.TABULATION);
                        break;
                    } 
                } // End of switch
                _loc4 = _loc4.nextSibling;
            } // end while
            if (_loc5.length == 0)
            {
                this.criticalError("CORRUPT_CONFIG_FILE", this.TABULATION, false);
                return;
            } // end if
            this.log(this.TABULATION + this.getText("CONFIG_FILE_LOADED"));
            this.askForConfiguration(_loc5);
        }
        else
        {
            this.criticalError("NO_CONFIG_FILE", this.TABULATION, false);
            return;
        } // end else if
    };
    _loc1.askForConfiguration = function (eaConfigurations)
    {
        if (eaConfigurations.length == 1 && eaConfigurations[0].data.connexionServers.length == 0)
        {
            this.chooseConfiguration(eaConfigurations[0].data, undefined, false);
        }
        else
        {
            this.logTitle(this.getText("CHOOSE_CONFIGURATION"));
            this._lstConfiguration.dataProvider = eaConfigurations;
            var _loc3 = this.getOptionsSharedObject().data.loaderLastConfName;
            if (_loc3 != undefined)
            {
                var _loc4 = 0;
                
                while (++_loc4, _loc4 < eaConfigurations.length)
                {
                    if (eaConfigurations[_loc4].data.name == _loc3)
                    {
                        this._lstConfiguration.selectedIndex = _loc4;
                        break;
                    } // end if
                } // end while
            }
            else
            {
                this._lstConfiguration.selectedIndex = 0;
            } // end else if
            this.selectConfiguration();
            this.showConfigurationChoice(true);
        } // end else if
    };
    _loc1.selectConfiguration = function ()
    {
        var _loc2 = this._lstConfiguration.selectedItem.data.connexionServers;
        this._lstConnexionServer.dataProvider = _loc2;
        var _loc3 = this.getOptionsSharedObject();
        var _loc4 = _loc3.data.loaderConf[this._lstConfiguration.selectedItem.label];
        if (_loc4 != undefined)
        {
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc2.length)
            {
                if (_loc2[_loc5].data.name == _loc4)
                {
                    this._lstConnexionServer.selectedIndex = _loc5;
                    break;
                } // end if
            } // end while
        }
        else if (_loc2.length > 0)
        {
            this._lstConnexionServer.selectedIndex = 0;
        } // end else if
        _loc3.data.loaderLastConfName = this._lstConfiguration.selectedItem.label;
        this.selectConnexionServer();
    };
    _loc1.selectConnexionServer = function ()
    {
        var _loc2 = this.getOptionsSharedObject();
        if (_loc2.data.loaderConf == undefined)
        {
            _loc2.data.loaderConf = new Object();
        } // end if
        _loc2.data.loaderConf[this._lstConfiguration.selectedItem.label] = this._lstConnexionServer.selectedItem.label;
    };
    _loc1.chooseConfiguration = function (oConf, oServer, bLog)
    {
        this.showConfigurationChoice(false);
        if (bLog)
        {
            this.log(this.TABULATION + this.getText("CURRENT_CONFIG", [oConf.name]));
            if (oServer != undefined)
            {
                this.log(this.TABULATION + this.getText("CURRENT_SERVER", [oServer.name]));
            } // end if
        } // end if
        _global.CONFIG.dataServers = oConf.dataServers;
        _global.CONFIG.connexionServer = oServer;
        if (oConf.debug)
        {
            dofus.Constants.DEBUG = true;
            this.logYellow(this.TABULATION + this.getText("DEBUG_MODE"));
        } // end if
        this.loadLocalFileList();
    };
    _loc1.startJsTimer = function ()
    {
        --this._nTimerJs;
        if (this._nTimerJs <= 0)
        {
            this._nTimerJs = 20;
            this.getURL("javascript:startTimer()");
        } // end if
        if (this._bJsTimer)
        {
            this.addToQueue({object: this, method: this.startJsTimer});
        } // end if
    };
    _loc1.loadLanguage = function ()
    {
        if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
        {
            this.getURL("javascript:startTimer()");
            this.startJsTimer();
        } // end if
        this.logTitle(this.getText("LOAD_LANG_FILE"));
        this._sStep = "LANG";
        this._aCurrentDataServers = this.copyAndOrganizeDataServerList();
        var _loc2 = this.getLangSharedObject().data.VERSIONS.lang;
        _global[dofus.Constants.GLOBAL_SO_LANG_NAME] = this.getLangSharedObject();
        this.log(this.TABULATION + this.getText("CURRENT_LANG_FILE_VERSION", [_loc2 == undefined ? ("Aucune") : (_loc2)]));
        this.log(this.TABULATION + this.getText("CHECK_LAST_VERSION"));
        this._oXtraCurrentVersion.lang = _global.isNaN(_loc2) ? (0) : (Number(_loc2));
        this.checkLanguageWithNextHost("lang," + _loc2);
    };
    _loc1.checkLanguageWithNextHost = function (sFiles)
    {
        if (this._aCurrentDataServers.length < 1)
        {
            if (!this._bLocalFileListLoaded)
            {
                this.criticalError("CHECK_LAST_VERSION_FAILED", this.TABULATION, true, new Array(), "checkXtra");
            }
            else
            {
                this.nonCriticalError("CHECK_LAST_VERSION_FAILED", this.TABULATION, true);
                var _loc2 = new LoadVars();
                var _loc3 = new Array();
                var _loc4 = this._mcLocalFileList.VERSIONS[_global.CONFIG.language];
                for (var i in _loc4)
                {
                    _loc3.push(i + "," + _global.CONFIG.language + "," + _loc4[i]);
                } // end of for...in
                _loc2.f = _loc3.join("|");
                this.onCheckLanguage(true, _loc2);
            } // end else if
            return;
        } // end if
        var oServer = this._aCurrentDataServers.shift();
        if (oServer.type == "local")
        {
            this.checkLanguageWithNextHost(sFiles);
            return;
        } // end if
        var _loc5 = oServer.url + "lang/versions_" + _global.CONFIG.language + ".txt" + "?wtf=" + Math.random();
        var _loc6 = new LoadVars();
        var loader = this;
        _loc6.onLoad = function (bSuccess)
        {
            loader.onCheckLanguage(bSuccess, this, oServer.url, sFiles);
        };
        this.showWaitBar(true);
        _loc6.load(_loc5, this, "GET");
    };
    _loc1.onCheckLanguage = function (bSuccess, lv, sServer, sFiles)
    {
        this.showWaitBar(false);
        if (bSuccess && lv.f != undefined)
        {
            this.setTotalBarValue(100, 100);
            this._sDistantFileList = lv.f;
            var _loc6 = lv.f.substr(lv.f.indexOf("lang,")).split("|")[0].split(",");
            var _loc7 = false;
            if (lv.f != "")
            {
                var _loc8 = _loc6[2];
                if (_global.CONFIG.language == this.getLangSharedObject().data.LANGUAGE && (this._oXtraCurrentVersion.lang != undefined && _loc8 == this._oXtraCurrentVersion.lang))
                {
                    _loc7 = true;
                }
                else
                {
                    this.log(this.TABULATION + this.getText("NEW_LANG_FILE_AVAILABLE", [_loc6[2]]));
                    if (this._bSkipDistantLoad)
                    {
                        if (this._oXtraCurrentVersion.lang == 0)
                        {
                            _loc8 = this._mcLocalFileList.VERSIONS[_global.CONFIG.language].lang;
                        } // end if
                    } // end if
                    this.updateLanguage(_loc6[2]);
                } // end else if
            }
            else
            {
                _loc7 = true;
            } // end else if
            if (_loc7)
            {
                this.log(this.TABULATION + this.getText("NO_NEW_VERSION_AVAILABLE"));
                this.loadModules();
            } // end if
        }
        else
        {
            this.nonCriticalError(this.getText("IMPOSSIBLE_TO_JOIN_SERVER", [sServer]), this.TABULATION + this.TABULATION);
            this.checkLanguageWithNextHost(sFiles);
        } // end else if
    };
    _loc1.updateLanguage = function (nFileNumber)
    {
        this._bUpdate = true;
        this.showWaitBar(true);
        var _loc3 = new dofus.utils.LangFileLoader();
        _loc3.addListener(this);
        _loc3.load(this.copyAndOrganizeDataServerList(), "lang/swf/lang_" + _global.CONFIG.language + "_" + nFileNumber + ".swf", this._mcContainer, dofus.Constants.LANG_SHAREDOBJECT_NAME, "lang", _global.CONFIG.language);
    };
    _loc1.loadModules = function ()
    {
        this.logTitle(this.getText("LOAD_MODULES"));
        this._sStep = "MODULE";
        this._aCurrentModules = dofus.Constants.MODULES_LIST.slice(0);
        this.loadNextModule();
    };
    _loc1.loadNextModule = function ()
    {
        if (this._aCurrentModules.length < 1)
        {
            this.logTitle(this.getText("INIT_END"));
            this.onCoreLoaded(_global.MODULE_CORE);
            return;
        }
        else
        {
            this._aCurrentModule = this._aCurrentModules.shift();
            var _loc2 = this._aCurrentModule[0];
            var _loc3 = this._aCurrentModule[1];
            var _loc4 = this._aCurrentModule[2];
            var _loc5 = this._aCurrentModule[4];
            this._mcCurrentModule = this._mcModules.createEmptyMovieClip("mc" + _loc5, this._mcModules.getNextHighestDepth());
            this._timedProgress = _global.setInterval(this.onTimedProgress, 1000, this, this._mclLoader, this._mcCurrentModule);
            this._mclLoader.loadClip(_loc3, this._mcCurrentModule);
        } // end else if
    };
    _loc1.onCoreLoaded = function (mcCore)
    {
        if (_global.CONFIG.isStreaming)
        {
            this._bJsTimer = false;
            this.getURL("javascript:stopTimer()");
        } // end if
        if ((this._bNonCriticalError || this._bUpdate) && dofus.Constants.DEBUG)
        {
            this.showNextButton(true);
            this.showCopyLogsButton(true);
            this.showShowLogsButton(true);
        }
        else
        {
            this.initCore(mcCore);
        } // end else if
    };
    _loc1.initCore = function (mcCore)
    {
        Key.removeListener(this);
        var _loc3 = dofus.DofusCore.getInstance();
        if (dofus.DofusCore.getInstance() == undefined)
        {
            _loc3 = new dofus.DofusCore(mcCore);
        } // end if
        _loc3.initStart();
        this._bNonCriticalError = false;
        this._bUpdate = false;
    };
    _loc1.loadLocalFileList = function ()
    {
        this.logTitle(this.getText("LOAD_XTRA_FILES"));
        this._aCurrentDataServers = this.copyAndOrganizeDataServerList();
        this.checkLocalFileListWithNextHost(dofus.Constants.LANG_LOCAL_FILE_LIST);
        this.showWaitBar(true);
    };
    _loc1.checkLocalFileListWithNextHost = function (sFiles)
    {
        if (this._aCurrentDataServers.length < 1)
        {
            this.nonCriticalError("CHECK_LAST_VERSION_FAILED", this.TABULATION, true);
            this.loadLanguage();
            return;
        } // end if
        var _loc2 = this._aCurrentDataServers.shift();
        var sURL = _loc2.url + sFiles;
        var loader = this;
        var _loc3 = new MovieClipLoader();
        var _loc4 = new Object();
        _loc4.onLoadInit = function (mc)
        {
            loader.loadLanguage();
            loader._bLocalFileListLoaded = true;
        };
        _loc4.onLoadError = function (mc)
        {
            loader.checkLocalFileListWithNextHost(sFiles);
        };
        _loc3.addListener(_loc4);
        _loc3.loadClip(sURL, this._mcLocalFileList);
    };
    _loc1.loadXtra = function ()
    {
        this.clearlogs();
        this.showLoader(true);
        this.showBanner(true);
        this.showMainLogger(false);
        this.showShowLogsButton(false);
        this.showConfigurationChoice(false);
        this.showNextButton(false);
        this.showContinueButton(false);
        this.showClearCacheButton(false);
        this.showCopyLogsButton(false);
        this.showProgressBar(false);
        this.launchBannerAnim(true);
        this.setTotalBarValue(0, 100);
        this.showBasicInformations();
        if (!this.checkOccurences())
        {
            this.showShowLogsButton(false);
            this.showCopyLogsButton(false);
            return;
        } // end if
        this.logTitle(this.getText("LOAD_XTRA_FILES"));
        this.log(this.TABULATION + this.getText("CHECK_LAST_VERSION"));
        this._sStep = "XTRA";
        this.moveProgressBar(-60);
        _global[dofus.Constants.GLOBAL_SO_XTRA_NAME] = ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME);
        this._aCurrentDataServers = this.copyAndOrganizeDataServerList();
        var _loc2 = this.getXtraSharedObject().data.VERSIONS;
        var _loc3 = _global.API.lang.getConfigText("XTRA_FILE");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4];
            var _loc6 = _loc2[_loc5] == undefined ? (0) : (_loc2[_loc5]);
            this._oXtraCurrentVersion[_loc5] = _loc6;
        } // end while
        this.showWaitBar(false);
        this._aXtraList = this._sDistantFileList.split("|");
        this._nTotalFile = this._aXtraList.length;
        this.updateNextXtra();
    };
    _loc1.updateNextXtra = function ()
    {
        if (this._bSkipDistantLoad && this._oCurrentXtraLoadFile != undefined)
        {
            this._aXtraList.push(this._oCurrentXtraLoadFile);
        } // end if
        if (this._aXtraList.length < 1)
        {
            this.noMoreXtra();
        }
        else
        {
            while (this._aXtraList.length > 0)
            {
                this.setTotalBarValue(10 + (90 - 90 / this._nTotalFile * (this._aXtraList.length - 1)), 100);
                this._aCurrentXtra = this._aXtraList.shift().split(",");
                if (this._aXtraList.length > 0 && this._aCurrentXtra[2])
                {
                    if (!this._bSkipDistantLoad)
                    {
                        this._oCurrentXtraLoadFile = this._aCurrentXtra;
                    } // end if
                    var _loc2 = this._aCurrentXtra[0];
                    var _loc3 = this._aCurrentXtra[1];
                    var _loc4 = this._aCurrentXtra[2];
                    if (_loc2 == "lang")
                    {
                        continue;
                    } // end if
                    this._mcProgressBarGroup.txtInfo.text = _loc2;
                    if (_global.CONFIG.language == this.getLangSharedObject().data.LANGUAGE && Number(_loc4) == this._oXtraCurrentVersion[_loc2])
                    {
                        continue;
                    } // end if
                    if (this._bLocalFileListLoaded)
                    {
                        if (this._bSkipDistantLoad)
                        {
                            if (this._oXtraCurrentVersion[_loc2] == 0)
                            {
                                _loc4 = this._mcLocalFileList.VERSIONS[_global.CONFIG.language][_loc2];
                            }
                            else
                            {
                                continue;
                            } // end else if
                            
                        } // end if
                    }
                    else if (this._bSkipDistantLoad)
                    {
                        return;
                        
                    } // end else if
                    this._bUpdate = true;
                    this._aCurrentXtra[3] = this._aCurrentXtra[0] + "_" + this._aCurrentXtra[1] + "_" + this._aCurrentXtra[2];
                    this.log(this.TABULATION + this.getText("UPDATE_FILE", [_loc2]));
                    this.showWaitBar(true);
                    var _loc5 = new dofus.utils.LangFileLoader();
                    _loc5.addListener(this);
                    if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
                    {
                        this.getURL("JavaScript:WriteLog(\'updateNextXtra;" + _loc2 + "_" + _global.CONFIG.language + "_" + _loc4 + "\')");
                    } // end if
                    _loc5.load(this.copyAndOrganizeDataServerList(), "lang/swf/" + _loc2 + "_" + _global.CONFIG.language + "_" + _loc4 + ".swf", this._mcContainer, dofus.Constants.XTRA_SHAREDOBJECT_NAME, _loc2, _global.CONFIG.language, true);
                    return;
                } // end if
            } // end while
            this.noMoreXtra();
        } // end else if
    };
    _loc1.noMoreXtra = function ()
    {
        this.logTitle(this.getText("INIT_END"));
        if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
        {
            this.getURL("JavaScript:WriteLog(\'XtraLangLoadEnd\')");
        } // end if
        if ((this._bNonCriticalError || this._bUpdate) && dofus.Constants.DEBUG)
        {
            this.showNextButton(true);
            this.showCopyLogsButton(true);
            this.showShowLogsButton(true);
        }
        else
        {
            this.initAndLoginFinished();
        } // end else if
    };
    _loc1.initAndLoginFinished = function ()
    {
        this.showLoader(false);
        _global.API.kernel.onInitAndLoginFinished();
        this._bNonCriticalError = false;
        this._bUpdate = false;
        this.launchBannerAnim(false);
        this.showBanner(false);
    };
    _loc1.checkCacheVersion = function ()
    {
        var _loc2 = new Date();
        var _loc3 = _loc2.getFullYear() + "-" + (_loc2.getMonth() + 1) + "-" + _loc2.getDate();
        if (!this.getCacheDateSharedObject().data.clearDate)
        {
            this.clearCache();
            this.getCacheDateSharedObject().data.clearDate = _loc3;
            this.getCacheDateSharedObject().flush(100);
            return (false);
        } // end if
        if (_global[dofus.Constants.GLOBAL_SO_LANG_NAME] && (_global[dofus.Constants.GLOBAL_SO_LANG_NAME].data.C.CLEAR_DATE && _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data.C.ENABLED_AUTO_CLEARCACHE))
        {
            if (this.getCacheDateSharedObject().data.clearDate < _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data.C.CLEAR_DATE)
            {
                this.clearCache();
                this.getCacheDateSharedObject().data.clearDate = _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data.C.CLEAR_DATE;
                this.getCacheDateSharedObject().flush();
                this.reboot();
                return (false);
            } // end if
        } // end if
        return (true);
    };
    _loc1.onLoadStart = function (mc)
    {
        this.showWaitBar(false);
        this.setProgressBarValue(0, 100);
    };
    _loc1.onTimedProgress = function (shit, ldr, target)
    {
        var _loc5 = ldr.getProgress(target);
        shit.setProgressBarValue(Number(_loc5.bytesLoaded), Number(_loc5.bytesTotal));
    };
    _loc1.onLoadError = function (mc, errorCode, httpStatus, oServer)
    {
        _global.clearInterval(this._timedProgress);
        this.showProgressBar(false);
        this.showWaitBar(false);
        switch (this._sStep)
        {
            case "LANG":
            {
                if (oServer.type == "local")
                {
                    this.log(this.TABULATION + this.TABULATION + this.getText("NO_FILE_IN_LOCAL", ["lang", oServer.url]));
                }
                else
                {
                    if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
                    {
                        this.getURL("JavaScript:WriteLog(\'onLoadError LANG-" + oServer.url + "lang" + "\')");
                    } // end if
                    this.nonCriticalError(this.getText("IMPOSSIBLE_TO_DOWNLOAD_FILE", ["lang", oServer.url]), this.TABULATION + this.TABULATION);
                } // end else if
                break;
            } 
            case "MODULE":
            {
                if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
                {
                    this.getURL("JavaScript:WriteLog(\'onLoadError MODULE-" + this._aCurrentModule[4] + "\')");
                } // end if
                this.criticalError("IMPOSSIBLE_TO_LOAD_MODULE", this.TABULATION, true, [this._aCurrentModule[4]]);
                break;
            } 
            case "XTRA":
            {
                if (oServer.type == "local")
                {
                    this.log(this.TABULATION + this.TABULATION + this.getText("NO_FILE_IN_LOCAL", [this._aCurrentXtra[3], oServer.url]));
                }
                else
                {
                    if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
                    {
                        this.getURL("JavaScript:WriteLog(\'onLoadError XTRA-" + oServer.url + this._aCurrentXtra[3] + "\')");
                    } // end if
                    this.nonCriticalError(this.getText("IMPOSSIBLE_TO_DOWNLOAD_FILE", [this._aCurrentXtra[3], oServer.url]), this.TABULATION + this.TABULATION);
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.onLoadComplete = function (mc)
    {
        _global.clearInterval(this._timedProgress);
        if (this._sStep == "MODULE")
        {
            _global["MODULE_" + this._aCurrentModule[4]] = mc;
        } // end if
    };
    _loc1.onLoadInit = function (mc, oServer)
    {
        this.showProgressBar(false);
        switch (this._sStep)
        {
            case "LANG":
            {
                this.logGreen(this.TABULATION + this.getText("UPDATE_FINISH", ["lang", oServer.url]));
                if (!this.checkCacheVersion())
                {
                    return;
                } // end if
                this.loadModules();
                break;
            } 
            case "MODULE":
            {
                this.log(this.TABULATION + this.getText("MODULE_LOADED", [this._aCurrentModule[4]]));
                if (!this.checkCacheVersion())
                {
                    return;
                } // end if
                this.loadNextModule();
                break;
            } 
            case "XTRA":
            {
                if (oServer.type == "local")
                {
                    this.logGreen(this.TABULATION + this.TABULATION + this.getText("FILE_LOADED", [this._aCurrentXtra[3], oServer.url]));
                }
                else
                {
                    this.logGreen(this.TABULATION + this.TABULATION + this.getText("UPDATE_FINISH", [this._aCurrentXtra[3], oServer.url]));
                } // end else if
                this._oCurrentXtraLoadFile = undefined;
                this.updateNextXtra();
                break;
            } 
        } // End of switch
    };
    _loc1.onCorruptFile = function (mc, totalBytes, oServer)
    {
        switch (this._sStep)
        {
            case "LANG":
            {
                this.nonCriticalError(this.getText("CORRUPT_FILE", ["lang", oServer.url, totalBytes]), this.TABULATION + this.TABULATION);
                break;
            } 
            case "XTRA":
            {
                this.nonCriticalError(this.getText("CORRUPT_FILE", [this._aCurrentXtra[3], oServer.url, totalBytes]), this.TABULATION + this.TABULATION);
                break;
            } 
        } // End of switch
    };
    _loc1.onCantWrite = function (mc)
    {
        switch (this._sStep)
        {
            case "LANG":
            {
                this.criticalError("WRITE_FAILED", this.TABULATION + this.TABULATION, true, ["lang"]);
                break;
            } 
            case "XTRA":
            {
                this.criticalError("WRITE_FAILED", this.TABULATION + this.TABULATION, true, [this._aCurrentXtra[3]]);
                break;
            } 
        } // End of switch
    };
    _loc1.onAllLoadFailed = function (mc)
    {
        this.showProgressBar(false);
        this.showWaitBar(false);
        if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
        {
            this.getURL("JavaScript:WriteLog(\'onAllLoadFailed;" + this._sStep + "\')");
        } // end if
        switch (this._sStep)
        {
            case "LANG":
            {
                if (!this._bSkipDistantLoad)
                {
                    this.criticalError("CANT_UPDATE_FILE", this.TABULATION + this.TABULATION, true, ["lang"]);
                }
                else
                {
                    this.nonCriticalError("CANT_UPDATE_FILE", this.TABULATION + this.TABULATION, true, ["lang"]);
                } // end else if
                this._bSkipDistantLoad = true;
                break;
            } 
            case "XTRA":
            {
                this._bSkipDistantLoad = true;
                this.nonCriticalError("CANT_UPDATE_FILE", this.TABULATION + this.TABULATION, true, [this._aCurrentXtra[3]]);
                this.updateNextXtra();
                break;
            } 
        } // End of switch
    };
    _loc1.onCoreDisplayed = function ()
    {
        this.launchBannerAnim(false);
        this.showBanner(false);
        this.showLoader(false);
    };
    ASSetPropFlags(_loc1, null, 1);
    _loc1.TABULATION = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    _loc1._sLogs = "";
    _loc1._sLang = "fr";
    _loc1._bLocalFileListLoaded = false;
    _loc1._bSkipDistantLoad = false;
    _loc1._oXtraCurrentVersion = new Object();
    _loc1._nTotalFile = 0;
    _loc1._nProgressIndex = 0;
    _loc1._nTimerJs = 0;
    _loc1._bJsTimer = true;
} // end if
#endinitclip
