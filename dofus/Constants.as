// Action script...

// [Initial MovieClip Action of sprite 821]
#initclip 30
class dofus.Constants extends Object
{
    function Constants()
    {
        super();
    } // End of the function
    static function getTeamFileFromType(nType, nAlignment)
    {
        var _loc1;
        switch (nType)
        {
            case 0:
            {
                if (nAlignment == 1)
                {
                    _loc1 = dofus.Constants.CHALLENGE_CLIP_FILE_ANGEL;
                }
                else if (nAlignment == 2)
                {
                    _loc1 = dofus.Constants.CHALLENGE_CLIP_FILE_DEMON;
                }
                else
                {
                    _loc1 = dofus.Constants.CHALLENGE_CLIP_FILE_NORMAL;
                } // end else if
                break;
            } 
            case 1:
            {
                if (nAlignment == 1)
                {
                    _loc1 = dofus.Constants.CHALLENGE_CLIP_FILE_ANGEL;
                }
                else if (nAlignment == 2)
                {
                    _loc1 = dofus.Constants.CHALLENGE_CLIP_FILE_DEMON;
                }
                else
                {
                    _loc1 = dofus.Constants.CHALLENGE_CLIP_FILE_MONSTER;
                } // end else if
                break;
            } 
            case 2:
            {
                _loc1 = dofus.Constants.CHALLENGE_CLIP_FILE_NORMAL;
                break;
            } 
            case 3:
            {
                _loc1 = dofus.Constants.CHALLENGE_CLIP_FILE_TAXCOLLECTOR;
                break;
            } 
        } // End of switch
        return (_loc1);
    } // End of the function
    static var DEBUG = false;
    static var VERSION = 1;
    static var SUBVERSION = 9;
    static var SUBSUBVERSION = 1;
    static var BUILD_NUMBER = 1151;
    static var VERSIONDATE = "Fri Sep 02 16:02:07 GMT+0200 2005";
    static var LANG_SHAREDOBJECT_NAME = "ANKLANGSO";
    static var XTRA_SHAREDOBJECT_NAME = "ANKXTRASO";
    static var OPTIONS_SHAREDOBJECT_NAME = "ANKOPTIONSSO";
    static var GLOBAL_SO_LANG_NAME = "SHARED_OBJECT_LANG";
    static var GLOBAL_SO_XTRA_NAME = "SHARED_OBJECT_XTRA";
    static var GLOBAL_SO_OPTIONS_NAME = "SHARED_OBJECT_OPTIONS";
    static var CLIPS_PATH = "clips/";
    static var MUSIC_PATH = "music/";
    static var MODULE_PATH = "modules/";
    static var STYLES_PATH = "styles/";
    static var CLIPS_PERSOS_PATH = dofus.Constants.CLIPS_PATH + "sprites/";
    static var SPELLS_PATH = dofus.Constants.CLIPS_PATH + "spells/";
    static var SPELLS_ICONS_PATH = dofus.Constants.SPELLS_PATH + "icons/";
    static var ITEMS_PATH = dofus.Constants.CLIPS_PATH + "items/";
    static var JOBS_ICONS_PATH = dofus.Constants.CLIPS_PATH + "jobs/";
    static var ARTWORKS_PATH = dofus.Constants.CLIPS_PATH + "artworks/";
    static var CARDS_PATH = dofus.Constants.CLIPS_PATH + "cards/";
    static var ALIGNMENTS_PATH = dofus.Constants.CLIPS_PATH + "alignments/";
    static var ORDERS_PATH = dofus.Constants.ALIGNMENTS_PATH + "orders/";
    static var FEATS_PATH = dofus.Constants.ALIGNMENTS_PATH + "feats/";
    static var GUILDS_MINI_PATH = dofus.Constants.ARTWORKS_PATH + "mini/";
    static var GUILDS_FACES_PATH = dofus.Constants.ARTWORKS_PATH + "faces/";
    static var GUILDS_BIG_PATH = dofus.Constants.ARTWORKS_PATH + "big/";
    static var ARTWORKS_BIG_PATH = dofus.Constants.ARTWORKS_PATH + "big/";
    static var GUILDS_SYMBOL_PATH = dofus.Constants.ARTWORKS_PATH + "symbols/";
    static var CINEMATICS_PATH = dofus.Constants.CLIPS_PATH + "cinematics/";
    static var SMILEYS_ICONS_PATH = dofus.Constants.CLIPS_PATH + "smileys/";
    static var EMOTES_ICONS_PATH = dofus.Constants.CLIPS_PATH + "emotes/";
    static var AURA_PATH = dofus.Constants.CLIPS_PATH + "auras/";
    static var EMBLEMS_BACK_PATH = dofus.Constants.CLIPS_PATH + "emblems/back/";
    static var EMBLEMS_UP_PATH = dofus.Constants.CLIPS_PATH + "emblems/up/";
    static var LOCAL_MAPS_PATH = dofus.Constants.CLIPS_PATH + "maps/";
    static var OFFLINE_PATH = dofus.Constants.CLIPS_PATH + "offline/";
    static var MODULE_CORE = "core.swf";
    static var MODULE_SOUNDS = "soma.swf";
    static var MODULE_CORE_FILE = dofus.Constants.MODULE_PATH + dofus.Constants.MODULE_CORE;
    static var MODULE_SOUNDS_FILE = dofus.Constants.MODULE_PATH + dofus.Constants.MODULE_SOUNDS;
    static var MODULES_LIST = [[dofus.Constants.MODULE_SOUNDS, dofus.Constants.MODULE_SOUNDS_FILE, 2, true, "SOMA"], [dofus.Constants.MODULE_CORE, dofus.Constants.MODULE_CORE_FILE, 1, false, "CORE"]];
    static var CONFIG_XML_FILE = "config.xml";
    static var GROUND_FILE = dofus.Constants.CLIPS_PATH + "ground.swf";
    static var OBJECTS_FILE = dofus.Constants.CLIPS_PATH + "objects.swf";
    static var CIRCLE_FILE = dofus.Constants.CLIPS_PATH + "circle.swf";
    static var EFFECTSICON_FILE = dofus.Constants.CLIPS_PATH + "effectsicons.swf";
    static var SMILEY_FILE = dofus.Constants.CLIPS_PATH + "smileys.swf";
    static var DEMON_ANGEL_FILE = dofus.Constants.CLIPS_PATH + "demonangel.swf";
    static var DEFAULT_CC_ICON_FILE = dofus.Constants.CLIPS_PATH + "defaultcc.swf";
    static var READY_FILE = dofus.Constants.CLIPS_PATH + "ready.swf";
    static var BOOK_FILE = dofus.Constants.CLIPS_PATH + "book.swf";
    static var FORBIDDEN_FILE = dofus.Constants.CLIPS_PATH + "forbidden.swf";
    static var CHALLENGE_CLIP_FILE_NORMAL = dofus.Constants.CLIPS_PERSOS_PATH + "0.swf";
    static var CHALLENGE_CLIP_FILE_ANGEL = dofus.Constants.CLIPS_PERSOS_PATH + "1.swf";
    static var CHALLENGE_CLIP_FILE_DEMON = dofus.Constants.CLIPS_PERSOS_PATH + "2.swf";
    static var CHALLENGE_CLIP_FILE_MONSTER = dofus.Constants.CLIPS_PERSOS_PATH + "3.swf";
    static var CHALLENGE_CLIP_FILE_TAXCOLLECTOR = dofus.Constants.CLIPS_PERSOS_PATH + "4.swf";
    static var CHALLENGE_CLIP_FILE_TAXCOLLECTOR_ATTACKERS = dofus.Constants.CLIPS_PERSOS_PATH + "5.swf";
    static var HTTP_LANG_FILE = "/files/lang/getlang.php";
    static var HTTP_XTRA_FILE = "/files/lang/getxtra.php";
    static var HTTP_VERSION_FILE = "/version";
    static var HTTP_SERVERS_LIST_FILE = "/files/login/xml/svrlst.xml";
    static var HTTP_ALERT_PATH = "/files/login/xml/";
    static var HTTP_ALERT_FILE = "alert.xml";
    static var CLICK_MIN_DELAY = 800;
    static var SEQUENCER_TIMEOUT = 10000;
    static var MAX_DATA_LENGTH = 200;
    static var GUILD_NAMES = [null, "Féca", "Osamodas", "Enutrof", "Sram", "Xélor", "Ecaflip", "Eniripsa", "Iop", "Crâ", "Sadida"];
    static var GUILD_ORDER = [10, 2, 3, 4, 5, 6, 7, 8, 9, 1, 11];
    static var GUILD_SPELLS = [null, [1, 2, 3, 4, 5, 6, 17, 9, 20, 18, 16, 14, 19, 8, 12, 11, 10, 13, 15, 7], [21, 22, 23, 24, 25, 27, 28, 29, 30, 31, 32, 33, 34, 35, 26, 36, 37, 38, 39, 40], [41, 42, 43, 44, 45, 46, 47, 48, 49, 53, 51, 52, 50, 54, 55, 56, 57, 58, 59, 60], [61, 62, 63, 75, 67, 74, 65, 66, 68, 73, 80, 79, 71, 72, 69, 64, 76, 77, 78, 70], [81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100], [101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120], [121, 122, 123, 124, 125, 126, 127, 128, 130, 131, 132, 133, 134, 135, 129, 136, 137, 138, 139, 140], [141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160], [161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180], [181, 182, 183, 200, 199, 191, 192, 193, 194, 190, 198, 189, 195, 196, 197, 184, 185, 186, 187, 188], [431, 432, 433, 434, 435, 436, 437, 438, 439, 441, 440, 442, 443, 444, 445, 446, 447, 448, 449, 450]];
    static var SMILEY_DELAY = 3000;
    static var INFO_CHAT_COLOR = "009900";
    static var MSG_CHAT_COLOR = "111111";
    static var MSGCHUCHOTE_CHAT_COLOR = "0066FF";
    static var ERROR_CHAT_COLOR = "C10000";
    static var GUILD_CHAT_COLOR = "663399";
    static var CELL_PATH_COLOR = 16737792;
    static var CELL_PATH_OVER_COLOR = 16737792;
    static var CELL_PATH_USED_COLOR = 2385558;
    static var CELL_PATH_SELECT_COLOR = 2385558;
    static var CELL_SPELL_EFFECT_COLOR = 16737792;
    static var CELL_SPELL_RANGE_COLOR = 2385558;
    static var CELL_MOVE_RANGE_COLOR = 39168;
    static var LIFE_POINT_COLOR = 16711680;
    static var ACTION_POINT_COLOR = 255;
    static var MAP_CURRENT_POSITION = 16711680;
    static var MAP_WAYPOINT_POSITION = 255;
    static var OVERHEAD_TEXT_CHARACTER = 16777215;
    static var OVERHEAD_TEXT_OTHER = 16777113;
    static var TEAMS_COLOR = [16711680, 255];
    static var ZONE_COLOR = [3355443, 14540253];
    static var AREA_ALIGNMENT_COLOR = [65280, 65535, 16711680];
    static var AREA_NO_ALIGNMENT_COLOR = 16777113;
    static var NPC_ALIGNMENT_COLOR = [6750105, 65535, 16737894];
    static var NIGHT_COLOR = {ra: 38, rb: 0, ga: 38, gb: 0, ba: 60, bb: 0};
    static var NOVICE_LEVEL = 5;
    static var SPELL_BOOST_MAX_LEVEL = 6;
    static var SPELL_BOOST_BONUS = [0, 1, 2, 3, 4, 10];
    static var MAX_PLAYERS_IN_TEAM = 8;
    static var MAX_PLAYERS_IN_CHALLENGE = 16;
    static var UPDATER_PORT = 4583;
    static var UPDATER_CONNECTION_TRY_DELAY = 500;
    static var MAX_UPDATER_CONNECTION_TRY = 5;
    static var EMBLEM_BACKS_COUNT = 17;
    static var EMBLEM_UPS_COUNT = 104;
} // End of Class
#endinitclip
