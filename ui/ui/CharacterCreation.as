package ui
{
    import d2api.SystemApi;
    import d2api.DataApi;
    import d2api.UiApi;
    import d2api.MountApi;
    import d2api.ColorApi;
    import d2api.SoundApi;
    import flash.utils.Dictionary;
    import flash.geom.ColorTransform;
    import d2components.GraphicContainer;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import d2components.Texture;
    import d2components.EntityDisplayer;
    import d2components.ColorPicker;
    import d2components.Input;
    import d2components.Label;
    import d2components.TextArea;
    import d2data.BreedRole;
    import d2data.Breed;
    import d2data.Head;
    import d2data.BreedRoleByBreed;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.CharacterCreationResult;
    import d2hooks.CharacterNameSuggestioned;
    import d2hooks.CharacterImpossibleSelection;
    import d2enums.ComponentHookList;
    import d2enums.ProtocolConstantsEnum;
    import flash.events.TextEvent;
    import __AS3__.vec.Vector;
    import d2actions.CharacterCreation;
    import d2actions.CharacterRemodelSelection;
    import d2actions.CharacterNameSuggestionRequest;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2actions.CharacterDeselection;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2enums.LocationEnum;
    import d2enums.CharacterCreationResultEnum;
    import com.ankamagames.dofusModuleLibrary.enum.LookTypeSoundEnum;
    import d2hooks.*;
    import d2actions.*;
    import __AS3__.vec.*;

    public class CharacterCreation 
    {

        public static const COLOR_GENERATION_METHODE_NUMBER:int = 3;
        private static var PROGRESS_ROLE_WIDTH:int;
        private static var MAX_BREED_ROLE_VALUE:int;
        private static var TYPE_CREATE:String = "create";
        private static var TYPE_REBREED:String = "rebreed";
        private static var TYPE_RELOOK:String = "relook";
        private static var TYPE_RECOLOR:String = "recolor";
        private static var TYPE_RENAME:String = "rename";
        private static var TYPE_REGENDER:String = "regender";

        public var output:Object;
        public var sysApi:SystemApi;
        public var dataApi:DataApi;
        public var uiApi:UiApi;
        public var mountApi:MountApi;
        public var colorApi:ColorApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var soundApi:SoundApi;
        private var _lang:String;
        private var _hasRights:Boolean = false;
        private var _activeModules:Array;
        private var _mandatoryModules:Array;
        private var _assetsUri:String;
        private var _bRequestCreation:Boolean = false;
        private var _aColors:Array;
        private var _aColorsBase:Object;
        private var _look:Object;
        private var _noStuffLook:Object;
        private var _equipmentSkinsStr:String = "";
        private var _gender:int;
        private var _breed:int;
        private var _name:String;
        private var _head:int;
        private var _direction:int = 3;
        private var _initialGender:int;
        private var _initialBreed:int;
        private var _initialName:String;
        private var _initialHead:int;
        private var _initialColors:Array;
        private var _aBreeds:Array;
        private var _aHeads:Array;
        private var _aRoles:Array;
        private var _aRolesByBreedId:Array;
        private var _componentsList:Dictionary;
        private var _breedIndex:int;
        private var _aTx_color:Array;
        private var _aGenders:Array;
        private var _yColorsUp:int;
        private var _yColorsDown:int;
        private var _selectedSlot:uint;
        private var _overSlot:uint;
        private var _frameCount:uint = 0;
        private var _aAnim:Array;
        private var _currentLook:String;
        private var _randomLookColors:Array;
        private var _randomColorEntityDisplayers:Array;
        private var _randomColorPage:int = -1;
        private var _randomInitialized:Boolean = false;
        private var _colorTransform:ColorTransform;
        public var creaCtr:GraphicContainer;
        public var ctr_breedInfos:GraphicContainer;
        public var ctr_colors:GraphicContainer;
        public var ctr_randomColor:GraphicContainer;
        public var gd_breed:Grid;
        public var gd_heads:Grid;
        public var gd_roles:Grid;
        public var gd_randomColorPreview:Grid;
        public var btn_randomRight:ButtonContainer;
        public var btn_randomLeft:ButtonContainer;
        public var tx_breedSymbol:Texture;
        public var tx_base:Texture;
        public var edChara:EntityDisplayer;
        public var tx_artwork:Texture;
        public var ctr_bgBreed:GraphicContainer;
        public var ctr_bgColor:GraphicContainer;
        public var ctr_bgHead:GraphicContainer;
        public var btn_sex1:ButtonContainer;
        public var btn_sex0:ButtonContainer;
        public var btn_color0:ButtonContainer;
        public var btn_color1:ButtonContainer;
        public var btn_color2:ButtonContainer;
        public var btn_color3:ButtonContainer;
        public var btn_color4:ButtonContainer;
        public var btn_reinitColor0:ButtonContainer;
        public var btn_reinitColor1:ButtonContainer;
        public var btn_reinitColor2:ButtonContainer;
        public var btn_reinitColor3:ButtonContainer;
        public var btn_reinitColor4:ButtonContainer;
        public var tx_color0:Texture;
        public var tx_color1:Texture;
        public var tx_color2:Texture;
        public var tx_color3:Texture;
        public var tx_color4:Texture;
        public var tx_colorsDisabled:Texture;
        public var cp_colorPk:ColorPicker;
        public var input_name:Input;
        public var lbl_name:Label;
        public var tx_name:Texture;
        public var tx_nameRules:Texture;
        public var btn_leftArrow:ButtonContainer;
        public var btn_rightArrow:ButtonContainer;
        public var btn_showEquipment:ButtonContainer;
        public var btn_breedInfo:ButtonContainer;
        public var btn_infoClose:ButtonContainer;
        public var btn_reinitColor:ButtonContainer;
        public var btn_generateColor:ButtonContainer;
        public var btn_generateName:ButtonContainer;
        public var btn_undo:ButtonContainer;
        public var btn_create:ButtonContainer;
        public var btn_lbl_btn_create:Label;
        public var lbl_titleCreation:Label;
        public var lbl_breed:Label;
        public var texta_breedInfo:TextArea;
        public var lbl_breedInfosTitle:Label;
        public var gd_breedAllRoles:Grid;
        public var gd_spells:Grid;
        public var ctr_hexaColor:GraphicContainer;
        public var inp_hexaValue:Input;
        public var btn_hexaOk:ButtonContainer;

        public function CharacterCreation()
        {
            this._activeModules = new Array();
            this._mandatoryModules = new Array();
            this._componentsList = new Dictionary(true);
            this._randomLookColors = new Array();
            this._randomColorEntityDisplayers = new Array();
            this._colorTransform = new ColorTransform();
            super();
        }

        public function main(params:Object=null):void
        {
            var role:BreedRole;
            var value:int;
            var breed:Breed;
            var head:Head;
            var colorI:*;
            var rbb:BreedRoleByBreed;
            var character:Object;
            var ic:int;
            var colorInt:int;
            var breedGenderHeads:Array;
            var index:int;
            var breedInfo:Breed;
            var currentHead:Head;
            var lookStrParts:Array;
            var lookSkins:Array;
            var currentHeadSkins:Array;
            var defaultLook:String;
            var defaultLookSkins:Array;
            var skinStr:String;
            var breedtemp:int;
            this.ctr_breedInfos.visible = false;
            this.ctr_hexaColor.visible = false;
            this.texta_breedInfo.hideScroll = true;
            this.btn_leftArrow.soundId = SoundEnum.SCROLL_DOWN;
            this.btn_rightArrow.soundId = SoundEnum.SCROLL_UP;
            this.btn_sex1.soundId = SoundEnum.CHECKBOX_CHECKED;
            this.btn_sex0.soundId = SoundEnum.CHECKBOX_UNCHECKED;
            this.btn_breedInfo.soundId = SoundEnum.SPEC_BUTTON;
            this.btn_undo.soundId = SoundEnum.CANCEL_BUTTON;
            this.btn_infoClose.soundId = SoundEnum.CANCEL_BUTTON;
            this.btn_showEquipment.visible = false;
            this.sysApi.addHook(CharacterCreationResult, this.onCharacterCreationResult);
            this.sysApi.addHook(CharacterNameSuggestioned, this.onCharacterNameSuggestioned);
            this.sysApi.addHook(CharacterImpossibleSelection, this.onCharacterImpossibleSelection);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addComponentHook(this.tx_nameRules, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_nameRules, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_showEquipment, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_showEquipment, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.edChara, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.edChara, ComponentHookList.ON_ENTITY_READY);
            this.uiApi.addComponentHook(this.gd_randomColorPreview, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.input_name, "onChange");
            this._yColorsUp = this.uiApi.me().getConstant("colors_y_up");
            this._yColorsDown = this.uiApi.me().getConstant("colors_y_down");
            this.ctr_randomColor.visible = false;
            this.ctr_colors.y = this._yColorsDown;
            if (((((params) && ((params[0] is Array)))) && ((params[1] is Array))))
            {
                this._activeModules = params[0];
                this._mandatoryModules = params[1];
            }
            else
            {
                this._activeModules.push(TYPE_CREATE);
            };
            if (this._activeModules.indexOf(TYPE_CREATE) != -1)
            {
                this.btn_lbl_btn_create.text = this.uiApi.getText("ui.charcrea.create");
            }
            else
            {
                this.btn_lbl_btn_create.text = this.uiApi.getText("ui.common.validation");
            };
            this._assetsUri = this.uiApi.me().getConstant("breedUri");
            PROGRESS_ROLE_WIDTH = int(this.uiApi.me().getConstant("progressbar_role_width"));
            this.input_name.maxChars = (ProtocolConstantsEnum.MAX_PLAYER_NAME_LEN - 1);
            this._lang = this.sysApi.getCurrentLanguage();
            this._hasRights = this.sysApi.getPlayerManager().hasRights;
            if (!(this._hasRights))
            {
                switch (this._lang)
                {
                    case "ru":
                        this.input_name.restrict = "^ ";
                        break;
                    case "ja":
                        this.input_name.restrict = "[ァ-ヾぁ-ゞA-Za-z\\-]+";
                        break;
                    case "fr":
                    case "en":
                    case "es":
                    case "de":
                    case "it":
                    case "nl":
                    case "pt":
                    default:
                        this.input_name.restrict = "A-Z\\-a-z";
                };
            };
            this._aTx_color = new Array(this.tx_color0, this.tx_color1, this.tx_color2, this.tx_color3, this.tx_color4);
            this._aGenders = new Array(this.btn_sex0, this.btn_sex1);
            this._aColors = new Array(-1, -1, -1, -1, -1);
            this._initialColors = new Array(-1, -1, -1, -1, -1);
            this._aRoles = new Array();
            for each (role in this.dataApi.getBreedRoles())
            {
                this._aRoles[role.id] = role;
            };
            this._aBreeds = new Array();
            this._aRolesByBreedId = new Array();
            MAX_BREED_ROLE_VALUE = 0;
            for each (breed in this.dataApi.getBreeds())
            {
                if ((Math.pow(2, (breed.id - 1)) & Connection.BREEDS_VISIBLE) > 0)
                {
                    this._aBreeds.push(breed);
                    this._aRolesByBreedId[breed.id] = new Array();
                    for each (rbb in breed.breedRoles)
                    {
                        if (MAX_BREED_ROLE_VALUE < rbb.value)
                        {
                            MAX_BREED_ROLE_VALUE = rbb.value;
                        };
                        this._aRolesByBreedId[breed.id][rbb.roleId] = {
                            "id":rbb.roleId,
                            "name":this._aRoles[rbb.roleId].name,
                            "color":this._aRoles[rbb.roleId].color,
                            "value":rbb.value,
                            "description":rbb.description,
                            "assetId":this._aRoles[rbb.roleId].assetId,
                            "order":rbb.order
                        };
                    };
                };
            };
            this.gd_breed.dataProvider = this._aBreeds;
            this._aHeads = new Array();
            for each (head in this.dataApi.getHeads())
            {
                this._aHeads.push(head);
            };
            if (((params) && (params[2])))
            {
                character = params[2];
                this._gender = int(character.gender);
                this._breed = character.breed;
                this._name = character.name;
                this._head = character.cosmeticId;
                this._initialGender = int(character.gender);
                this._initialBreed = character.breed;
                this._initialName = character.name;
                this._initialHead = character.cosmeticId;
                this.input_name.text = this._name;
                ic = 0;
                for each (colorInt in character.colors)
                {
                    this._aColors[ic] = colorInt;
                    this._initialColors[ic] = colorInt;
                    ic++;
                };
                this._look = this.mountApi.getRiderEntityLook(character.entityLook);
                this.edChara.clearSubEntities = false;
                this._breedIndex = (this._breed - 1);
                this.gd_breed.selectedIndex = this._breedIndex;
                breedGenderHeads = new Array();
                for each (head in this._aHeads)
                {
                    if ((((head.breed == this._breed)) && ((head.gender == this._gender))))
                    {
                        breedGenderHeads.push(head);
                    };
                };
                breedGenderHeads.sortOn("order", Array.NUMERIC);
                this.gd_heads.dataProvider = breedGenderHeads;
                this.getHeadFromLook();
                index = 0;
                for each (head in this.gd_heads.dataProvider)
                {
                    if (head.id == this._head)
                    {
                        this.gd_heads.selectedIndex = index;
                        break;
                    };
                    index++;
                };
                if (this._look.getBone() != 1)
                {
                    this._look = null;
                    this.btn_showEquipment.softDisabled = true;
                    this.btn_showEquipment.selected = false;
                }
                else
                {
                    this.btn_showEquipment.selected = true;
                    breedInfo = this._aBreeds[this._breedIndex];
                    currentHead = this.dataApi.getHead(this._head);
                    lookStrParts = this._look.toString().split("|");
                    lookSkins = lookStrParts[1].split(",");
                    currentHeadSkins = currentHead.skins.split(",");
                    if (this._gender == 0)
                    {
                        defaultLook = breedInfo.maleLook;
                    }
                    else
                    {
                        defaultLook = breedInfo.femaleLook;
                    };
                    defaultLookSkins = defaultLook.split("|")[1].split(",");
                    for each (skinStr in lookSkins)
                    {
                        if ((((defaultLookSkins.indexOf(skinStr) == -1)) && ((currentHeadSkins.indexOf(skinStr) == -1))))
                        {
                            this._equipmentSkinsStr = (this._equipmentSkinsStr + (skinStr + ","));
                        };
                    };
                    if (this._equipmentSkinsStr != "")
                    {
                        this._equipmentSkinsStr = this._equipmentSkinsStr.slice(0, (this._equipmentSkinsStr.length - 1));
                    };
                };
                this.displayBreed();
            }
            else
            {
                this._gender = Math.round(Math.random());
                breedtemp = -1;
                if (Connection.BREEDS_AVAILABLE > 0)
                {
                    do 
                    {
                        breedtemp = Math.floor((Math.random() * this._aBreeds.length));
                    } while ((Math.pow(2, (this._aBreeds[breedtemp].id - 1)) & Connection.BREEDS_AVAILABLE) <= 0);
                    this.gd_breed.selectedIndex = breedtemp;
                }
                else
                {
                    this.gd_breed.selectedIndex = -1;
                };
                this.gd_heads.selectedIndex = 0;
            };
            if (this._activeModules.indexOf(TYPE_CREATE) != -1)
            {
                this.lbl_name.text = this.uiApi.getText("ui.charcrea.titleRename");
                this.lbl_titleCreation.text = this.uiApi.getText("ui.charcrea.title");
                this.input_name.textfield.addEventListener(TextEvent.TEXT_INPUT, this.onInput);
            }
            else
            {
                if (((((!((this._activeModules.indexOf(TYPE_RECOLOR) == -1))) || (!((this._activeModules.indexOf(TYPE_RELOOK) == -1))))) || (!((this._activeModules.indexOf(TYPE_REBREED) == -1)))))
                {
                    this.btn_showEquipment.visible = true;
                };
                if (this._activeModules.indexOf(TYPE_RENAME) != -1)
                {
                    this.input_name.textfield.addEventListener(TextEvent.TEXT_INPUT, this.onInput);
                };
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.charcrea.characterModificationWarning"), [this.uiApi.getText("ui.common.ok")]);
            };
            for (colorI in this._aColors)
            {
                if (this._aTx_color[colorI])
                {
                    this.changeColor(this._aTx_color[colorI], this._aColors[colorI]);
                };
            };
            this.gd_randomColorPreview.dataProvider = new Array(-1, -1, -1, -1);
            this.uiApi.setRadioGroupSelectedItem("colorGroup", this.btn_color0, this.uiApi.me());
            this._aAnim = new Array("AnimStatique", "AnimMarche", "AnimCourse", "AnimAttaque0");
            this.switchMode();
        }

        public function unload():void
        {
            this.input_name.textfield.removeEventListener(TextEvent.TEXT_INPUT, this.onInput);
        }

        private function switchMode():void
        {
            if (this._activeModules.indexOf(TYPE_CREATE) != -1)
            {
                return;
            };
            this.gd_breed.disabled = true;
            this.ctr_bgBreed.disabled = true;
            this.btn_breedInfo.disabled = true;
            this.btn_sex0.disabled = true;
            this.btn_sex1.disabled = true;
            this.btn_color0.disabled = true;
            this.btn_color1.disabled = true;
            this.btn_color2.disabled = true;
            this.btn_color3.disabled = true;
            this.btn_color4.disabled = true;
            this.tx_colorsDisabled.visible = true;
            this.ctr_bgColor.disabled = true;
            this.btn_reinitColor0.visible = false;
            this.btn_reinitColor1.visible = false;
            this.btn_reinitColor2.visible = false;
            this.btn_reinitColor3.visible = false;
            this.btn_reinitColor4.visible = false;
            this.cp_colorPk.disabled = true;
            this.btn_reinitColor.disabled = true;
            this.btn_generateColor.disabled = true;
            this.gd_heads.disabled = true;
            this.ctr_bgHead.disabled = true;
            this.input_name.disabled = true;
            this.tx_name.disabled = true;
            this.btn_generateName.disabled = true;
            this.btn_showEquipment.visible = false;
            if (this._activeModules.indexOf(TYPE_RENAME) != -1)
            {
                this.input_name.disabled = false;
                this.tx_name.disabled = false;
                this.btn_generateName.disabled = false;
            };
            if (this._activeModules.indexOf(TYPE_RELOOK) != -1)
            {
                this.gd_heads.disabled = false;
                this.ctr_bgHead.disabled = false;
                this.btn_showEquipment.visible = true;
            };
            if (this._activeModules.indexOf(TYPE_RECOLOR) != -1)
            {
                this.btn_color0.disabled = false;
                this.btn_color1.disabled = false;
                this.btn_color2.disabled = false;
                this.btn_color3.disabled = false;
                this.btn_color4.disabled = false;
                this.tx_colorsDisabled.visible = false;
                this.ctr_bgColor.disabled = false;
                this.btn_reinitColor0.visible = true;
                this.btn_reinitColor1.visible = true;
                this.btn_reinitColor2.visible = true;
                this.btn_reinitColor3.visible = true;
                this.btn_reinitColor4.visible = true;
                this.cp_colorPk.disabled = false;
                this.btn_reinitColor.disabled = false;
                this.btn_generateColor.disabled = false;
                this.btn_showEquipment.visible = true;
            };
            if (this._activeModules.indexOf(TYPE_REBREED) != -1)
            {
                this.gd_breed.disabled = false;
                this.ctr_bgBreed.disabled = false;
                this.btn_breedInfo.disabled = false;
                this.btn_showEquipment.visible = true;
            };
            if (this._activeModules.indexOf(TYPE_REGENDER) != -1)
            {
                this.btn_sex0.disabled = false;
                this.btn_sex1.disabled = false;
                this.btn_showEquipment.visible = true;
            };
        }

        private function displayCharacter():void
        {
            var colorIndex:*;
            var currentHead:Head;
            var hexaColor:String;
            var lookStr:String = "";
            var artworkLookStr:String = "";
            var breedInfo:Breed = this._aBreeds[this._breedIndex];
            if (this._gender == 0)
            {
                lookStr = breedInfo.maleLook;
                artworkLookStr = (("{" + breedInfo.maleArtwork) + "}");
                this._aColorsBase = breedInfo.maleColors;
            }
            else
            {
                lookStr = breedInfo.femaleLook;
                artworkLookStr = (("{" + breedInfo.femaleArtwork) + "}");
                this._aColorsBase = breedInfo.femaleColors;
            };
            var colorStr:String = "";
            for (colorIndex in this._aColors)
            {
                if (this._aColors[colorIndex] != -1)
                {
                    hexaColor = this._aColors[colorIndex].toString(16);
                }
                else
                {
                    if (((this._aColorsBase) && ((this._aColorsBase.length > colorIndex))))
                    {
                        hexaColor = this._aColorsBase[colorIndex].toString(16);
                    }
                    else
                    {
                        hexaColor = (Math.random() * 0xFFFFFF).toString(16);
                    };
                };
                colorStr = (colorStr + ((((colorIndex + 1) + "=#") + hexaColor) + ","));
            };
            colorStr = colorStr.substring(0, (colorStr.length - 1));
            currentHead = this.dataApi.getHead(this._head);
            if (((((currentHead) && (currentHead.skins))) && (!((currentHead.skins == "0")))))
            {
                lookStr = lookStr.replace("||", (("," + currentHead.skins) + "||"));
            };
            lookStr = lookStr.replace("||", (("|" + colorStr) + "|"));
            artworkLookStr = artworkLookStr.replace("}", (("||" + colorStr) + "}"));
            if (((((!(this.btn_showEquipment.disabled)) && (!(this.btn_showEquipment.softDisabled)))) && (this.btn_showEquipment.visible)))
            {
                this.displayEquipment(lookStr);
            }
            else
            {
                this.edChara.look = this.sysApi.getEntityLookFromString(lookStr);
            };
            this.updateDirection(this._direction);
            this._currentLook = lookStr;
            this.tx_artwork.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("artwork_uri") + this._breed) + "") + this._gender));
        }

        private function colorizeCharacter():void
        {
            var color:*;
            for (color in this._aColors)
            {
                if (this._aColors[color] != -1)
                {
                    this.edChara.setColor((color + 1), this._aColors[color]);
                }
                else
                {
                    if (this._aColorsBase.length > color)
                    {
                        this.edChara.setColor((color + 1), this._aColorsBase[color]);
                    };
                };
            };
        }

        private function generateColors():void
        {
            var generatedColor:*;
            var i:int;
            var tempArray:Array;
            var limit:int;
            var j:int;
            if (!(this.ctr_randomColor.visible))
            {
                this.ctr_randomColor.visible = true;
                this.ctr_colors.y = this._yColorsUp;
            };
            var x:int;
            var y:int;
            var slide:int;
            switch (this._breed)
            {
                case 12:
                    y = ((Math.random() * 750) + 250);
                    if (y > 750)
                    {
                        x = (Math.random() * 1000);
                    }
                    else
                    {
                        x = ((Math.random() * 90) + 50);
                    };
                    slide = (Math.random() * 100);
                    break;
                case 6:
                    x = ((Math.random() * 140) + 25);
                    y = ((Math.random() * 700) + 200);
                    slide = ((Math.random() * 80) + 10);
                    break;
                default:
                    x = ((Math.random() * 90) + 50);
                    y = ((Math.random() * 650) + 250);
                    slide = ((Math.random() * 80) + 10);
            };
            var color:uint = this.getColorByXYSlideX(x, y, slide);
            var pageArray:Array = new Array();
            i = 0;
            while (i <= COLOR_GENERATION_METHODE_NUMBER)
            {
                tempArray = new Array();
                tempArray[0] = color;
                generatedColor = this.colorApi.generateColorList(i);
                limit = Math.min(4, generatedColor.length);
                j = 0;
                while (j < limit)
                {
                    tempArray[(j + 1)] = generatedColor[j];
                    j++;
                };
                pageArray.push(tempArray);
                i++;
            };
            this._randomLookColors.push(pageArray);
            this._randomColorPage = (this._randomLookColors.length - 1);
            this.updateRandomColorLook();
        }

        private function changeRandomPage(pageNumber:int):void
        {
            if (pageNumber == 99)
            {
                pageNumber = 0;
            }
            else
            {
                if (pageNumber == -1)
                {
                    pageNumber = 99;
                };
            };
            this._randomColorPage = pageNumber;
            this.updateRandomColorLook();
        }

        private function getHeadFromLook():void
        {
            var head:Head;
            var lookStrParts:Array = this._look.toString().split("|");
            for each (head in this._aHeads)
            {
                if ((((head.breed == this._breed)) && ((head.gender == this._gender))))
                {
                    if (((lookStrParts[1]) && (!((lookStrParts[1].indexOf(head.skins) == -1)))))
                    {
                        this._head = head.id;
                        return;
                    };
                };
            };
        }

        public function updateBreed(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!(this._componentsList[componentsRef.ctr_breed.name]))
            {
                this.uiApi.addComponentHook(componentsRef.ctr_breed, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.ctr_breed, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[componentsRef.ctr_breed.name] = data;
            if (data)
            {
                if (data.id < 10)
                {
                    componentsRef.tx_breed.uri = this.uiApi.createUri(((((this.uiApi.me().getConstant("breed_uri") + "assets.swf|CreaPerso_btn_") + this._gender) + "0") + data.id));
                }
                else
                {
                    componentsRef.tx_breed.uri = this.uiApi.createUri(((((this.uiApi.me().getConstant("breed_uri") + "assets.swf|CreaPerso_btn_") + this._gender) + "") + data.id));
                };
                if (selected)
                {
                    componentsRef.tx_selected.visible = true;
                }
                else
                {
                    componentsRef.tx_selected.visible = false;
                };
                if ((((Connection.BREEDS_AVAILABLE > 0)) && (((Math.pow(2, (data.id - 1)) & Connection.BREEDS_AVAILABLE) > 0))))
                {
                    componentsRef.tx_grey.visible = false;
                }
                else
                {
                    componentsRef.tx_grey.visible = true;
                };
            };
        }

        public function updateHead(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!(this._componentsList[componentsRef.btn_head.name]))
            {
                this.uiApi.addComponentHook(componentsRef.btn_head, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.btn_head, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[componentsRef.btn_head.name] = data;
            if (data)
            {
                componentsRef.tx_head.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("heads_uri") + data.assetId) + ".png"));
                if (selected)
                {
                    componentsRef.tx_hselected.visible = true;
                }
                else
                {
                    componentsRef.tx_hselected.visible = false;
                };
            };
        }

        public function updateRole(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!(this._componentsList[componentsRef.ctr_roleItem.name]))
            {
                this.uiApi.addComponentHook(componentsRef.ctr_roleItem, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.ctr_roleItem, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[componentsRef.ctr_roleItem.name] = data;
            if (data)
            {
                componentsRef.tx_role.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("breed_uri") + "breedRoles.swf|roles_") + data.assetId));
                componentsRef.lbl_role.text = data.name;
            };
        }

        public function updateInfoRole(data:*, componentsRef:*, selected:Boolean):void
        {
            var percent:int;
            if (!(this._componentsList[componentsRef.lbl_role.name]))
            {
                this.uiApi.addComponentHook(componentsRef.lbl_role, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.lbl_role, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[componentsRef.lbl_role.name] = data;
            if (data)
            {
                componentsRef.lbl_role.text = data.name;
                componentsRef.tx_roleSmall.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("breed_uri") + "breedRoles.swf|roles_") + data.assetId));
                percent = Math.floor(((data.value / MAX_BREED_ROLE_VALUE) * 100));
                if (percent > 100)
                {
                    percent = 100;
                };
                this._colorTransform.color = data.color;
                this._colorTransform.redMultiplier = 0.3;
                this._colorTransform.greenMultiplier = 0.3;
                this._colorTransform.blueMultiplier = 0.3;
                componentsRef.tx_roleProgress.transform.colorTransform = this._colorTransform;
                componentsRef.tx_roleProgress.width = (percent * (PROGRESS_ROLE_WIDTH / 100));
                componentsRef.tx_roleProgressBg.width = (componentsRef.tx_roleProgress.width + 2);
            };
        }

        public function updatePreviewLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!(this._componentsList[componentsRef.btn_randomLook.name]))
            {
                this.uiApi.addComponentHook(componentsRef.btn_randomLook, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.btn_randomLook, ComponentHookList.ON_ROLL_OUT);
            };
            this._componentsList[componentsRef.btn_randomLook.name] = data;
            if (((data) && ((this._randomColorEntityDisplayers.length <= 6))))
            {
                this._randomColorEntityDisplayers.push(componentsRef.ed_charPreview);
            };
        }

        private function displayBreed():void
        {
            var brbb:Object;
            var spells:Array;
            var id:*;
            this.tx_breedSymbol.gotoAndStop = this._breed.toString();
            var sortedRoles:Array = new Array();
            var allRoles:Array = new Array();
            for each (brbb in this._aRolesByBreedId[this._breed])
            {
                if (brbb.order > 0)
                {
                    sortedRoles.push(brbb);
                };
                allRoles.push(brbb);
            };
            sortedRoles.sortOn("order", Array.NUMERIC);
            this.gd_roles.dataProvider = sortedRoles;
            this.gd_breedAllRoles.dataProvider = allRoles;
            this.updateGender(this._gender);
            if (!(this._aBreeds[this._breedIndex]))
            {
                this.lbl_breed.text = "?";
                this.texta_breedInfo.text = "?";
                this.lbl_breedInfosTitle.text = "?";
            }
            else
            {
                this.lbl_breed.text = this._aBreeds[this._breedIndex].longName;
                this.lbl_breedInfosTitle.text = this._aBreeds[this._breedIndex].shortName;
                this.texta_breedInfo.text = this._aBreeds[this._breedIndex].description;
                spells = new Array();
                for each (id in this._aBreeds[this._breedIndex].breedSpellsId)
                {
                    spells.push(this.dataApi.getSpellWrapper(id));
                };
                this.gd_spells.dataProvider = spells;
            };
        }

        private function updateGender(nGender:int, force:Boolean=false):void
        {
            var head:Head;
            if (((!(this._aGenders[nGender].selected)) || (force)))
            {
                this._gender = nGender;
                this.uiApi.setRadioGroupSelectedItem("genderGroup", this._aGenders[this._gender], this.uiApi.me());
                this.gd_breed.dataProvider = this._aBreeds;
            };
            var breedGenderHeads:Array = new Array();
            var i:int;
            var headIndex:int;
            for each (head in this._aHeads)
            {
                if ((((head.breed == this._breed)) && ((head.gender == this._gender))))
                {
                    breedGenderHeads.push(head);
                    if ((((this._head > 0)) && ((head.id == this._head))))
                    {
                        headIndex = i;
                    };
                    i++;
                };
            };
            breedGenderHeads.sortOn("order", Array.NUMERIC);
            this._head = breedGenderHeads[headIndex].id;
            this.gd_heads.dataProvider = breedGenderHeads;
            this.gd_heads.silent = true;
            this.gd_heads.selectedIndex = headIndex;
            this.gd_heads.silent = false;
            this.displayCharacter();
        }

        private function createCharacter():void
        {
            var reason:String;
            var remodelErrorText:String;
            var ic:int;
            var nbSimilarColors:int;
            var colorInt:int;
            var vectColors:Vector.<int>;
            var c:int;
            if (Connection.BREEDS_AVAILABLE == 0)
            {
                return;
            };
            var nameError:uint;
            if (((!((this._activeModules.indexOf(TYPE_CREATE) == -1))) || (!((this._activeModules.indexOf(TYPE_RENAME) == -1)))))
            {
                this._name = this.input_name.text;
                if (this._hasRights)
                {
                    if (this._name.length < 2)
                    {
                        this.sysApi.log(8, (this._name + " trop court"));
                        nameError = 1;
                    };
                }
                else
                {
                    if (this._lang != "ru")
                    {
                        if (this._lang != "ja")
                        {
                            nameError = this.verifName();
                        }
                        else
                        {
                            nameError = this.verifNameJa();
                        };
                    };
                };
            };
            if (((!(this._name)) || ((this._name == ""))))
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.popup.charcrea.noName"), [this.uiApi.getText("ui.common.ok")]);
                this._bRequestCreation = false;
                this.btn_create.disabled = false;
                return;
            };
            if (nameError > 0)
            {
                reason = this.uiApi.getText(("ui.charcrea.invalidNameReason" + nameError));
                this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), ((this.uiApi.getText("ui.popup.charcrea.invalidName") + "\n\n") + reason), [this.uiApi.getText("ui.common.ok")]);
                this._bRequestCreation = false;
                this.btn_create.disabled = false;
                return;
            };
            if (this._activeModules.indexOf(TYPE_CREATE) == -1)
            {
                remodelErrorText = "";
                if (((!((this._mandatoryModules.indexOf(TYPE_RENAME) == -1))) && ((this._name == this._initialName))))
                {
                    remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryName");
                };
                if (this._mandatoryModules.indexOf(TYPE_RECOLOR) != -1)
                {
                    ic = 0;
                    nbSimilarColors = 0;
                    for each (colorInt in this._aColors)
                    {
                        if (this._aColors[ic] == this._initialColors[ic])
                        {
                            nbSimilarColors++;
                        };
                        ic++;
                    };
                    if (nbSimilarColors == ic)
                    {
                        remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryColors");
                    };
                };
                if (((!((this._mandatoryModules.indexOf(TYPE_RELOOK) == -1))) && ((this._head == this._initialHead))))
                {
                    remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryHead");
                };
                if (((!((this._mandatoryModules.indexOf(TYPE_REGENDER) == -1))) && ((this._gender == this._initialGender))))
                {
                    remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryGender");
                };
                if (((!((this._mandatoryModules.indexOf(TYPE_REBREED) == -1))) && ((this._breed == this._initialBreed))))
                {
                    remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryBreed");
                };
                if (remodelErrorText != "")
                {
                    reason = this.uiApi.getText(("ui.charcrea.invalidNameReason" + nameError));
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), remodelErrorText, [this.uiApi.getText("ui.common.ok")]);
                    this._bRequestCreation = false;
                    this.btn_create.disabled = false;
                    return;
                };
            };
            Connection.waitingForCharactersList = true;
            this.lockCreation();
            if (this._activeModules.indexOf(TYPE_CREATE) != -1)
            {
                this.sysApi.sendAction(new CharacterCreation(this._name, this._breed, !((this._gender == 0)), this._aColors, this._head));
            }
            else
            {
                vectColors = new Vector.<int>();
                for each (c in this._aColors)
                {
                    vectColors.push(c);
                };
                this.sysApi.sendAction(new CharacterRemodelSelection(0, !((this._gender == 0)), this._breed, this._head, this._name, vectColors));
            };
        }

        private function changeColor(obj:Object, color:Number=0xFFFFFF):void
        {
            var t:ColorTransform;
            if (color != -1)
            {
                t = new ColorTransform();
                t.color = color;
                obj.transform.colorTransform = t;
                obj.visible = true;
                this.edChara.setColor(this._aColors.indexOf(color), this._aColors[color]);
            }
            else
            {
                obj.visible = false;
                this.edChara.resetColor((color + 1));
            };
        }

        private function wheelChara(sens:int):void
        {
            var dir:int = (((this._direction + sens) + 8) % 8);
            this.updateDirection(dir);
        }

        private function resetColor(colorIndex:int=-1):void
        {
            var i:*;
            if (colorIndex == -1)
            {
                for (i in this._aTx_color)
                {
                    this._aColors[i] = -1;
                    this.changeColor(this._aTx_color[i], this._aColors[i]);
                };
            }
            else
            {
                this._aColors[colorIndex] = -1;
                this.changeColor(this._aTx_color[colorIndex], -1);
            };
            this.colorizeCharacter();
        }

        private function verifName():uint
        {
            var part:*;
            var iCarac:int;
            if (this._name.length < ProtocolConstantsEnum.MIN_PLAYER_NAME_LEN)
            {
                this.sysApi.log(8, (this._name + " trop court"));
                return (1);
            };
            if (this._name.length > ProtocolConstantsEnum.MAX_PLAYER_NAME_LEN)
            {
                this.sysApi.log(8, (this._name + " trop long"));
                return (1);
            };
            var nameNoCase:String = this._name.toLowerCase();
            if (((((((((((((((((((((((((((!((nameNoCase.indexOf("xelor") == -1))) || (!((nameNoCase.indexOf("iop") == -1))))) || (!((nameNoCase.indexOf("feca") == -1))))) || (!((nameNoCase.indexOf("eniripsa") == -1))))) || (!((nameNoCase.indexOf("sadida") == -1))))) || (!((nameNoCase.indexOf("ecaflip") == -1))))) || (!((nameNoCase.indexOf("enutrof") == -1))))) || (!((nameNoCase.indexOf("pandawa") == -1))))) || (!((nameNoCase.indexOf("sram") == -1))))) || (!((nameNoCase.indexOf("cra") == -1))))) || (!((nameNoCase.indexOf("osamodas") == -1))))) || (!((nameNoCase.indexOf("sacrieur") == -1))))) || (!((nameNoCase.indexOf("drop") == -1))))) || (!((nameNoCase.indexOf("mule") == -1)))))
            {
                this.sysApi.log(8, (this._name + " contenant un mot interdit"));
                return (2);
            };
            var namePart:Array = this._name.split("-");
            if (namePart.length > 2)
            {
                this.sysApi.log(8, (this._name + " contenant plus d'un tiret"));
                return (3);
            };
            if ((((this._name.indexOf("-") == 0)) || ((this._name.indexOf("-") == 1))))
            {
                this.sysApi.log(8, (this._name + " tiret placé en 1 ou 2"));
                return (3);
            };
            if (namePart[0].charAt(0) != namePart[0].charAt(0).toUpperCase())
            {
                this.sysApi.log(8, (this._name + " manque de majuscule"));
                return (4);
            };
            for each (part in namePart)
            {
                iCarac = 0;
                while (iCarac < part.length)
                {
                    if (part.charAt(iCarac) == part.charAt(iCarac).toUpperCase())
                    {
                        if (iCarac != 0)
                        {
                            this.sysApi.log(8, (this._name + " majuscule en milieu de nom"));
                            return (4);
                        };
                    };
                    iCarac++;
                };
            };
            if ((((((((((((nameNoCase.indexOf("a") == -1)) && ((nameNoCase.indexOf("e") == -1)))) && ((nameNoCase.indexOf("i") == -1)))) && ((nameNoCase.indexOf("o") == -1)))) && ((nameNoCase.indexOf("u") == -1)))) && ((nameNoCase.indexOf("y") == -1))))
            {
                this.sysApi.log(8, (this._name + " pas de voyelles"));
                return (5);
            };
            var iC:int;
            while (iC < (this._name.length - 2))
            {
                if (this._name.charAt(iC) == this._name.charAt((iC + 1)))
                {
                    if (this._name.charAt(iC) == this._name.charAt((iC + 2)))
                    {
                        this.sysApi.log(8, (this._name + " plus de 2 lettres identiques à la suite"));
                        return (6);
                    };
                };
                iC++;
            };
            return (0);
        }

        private function verifNameJa():uint
        {
            if (this._name.length < 2)
            {
                this.sysApi.log(8, (this._name + " trop court"));
                return (1);
            };
            if (this._name.length > 19)
            {
                this.sysApi.log(8, (this._name + " trop long"));
                return (1);
            };
            return (0);
        }

        private function pickColor(index:uint):void
        {
            var position:int;
            this._selectedSlot = index;
            if (this.uiApi.keyIsDown(16))
            {
                if (this._aColors[index] != -1)
                {
                    this.inp_hexaValue.text = this._aColors[index].toString(16);
                }
                else
                {
                    this.inp_hexaValue.text = "";
                };
                this.ctr_hexaColor.visible = true;
                this.inp_hexaValue.focus();
                position = this.inp_hexaValue.text.length;
                this.inp_hexaValue.setSelection(position, position);
            }
            else
            {
                if (this._aColors[index] != -1)
                {
                    this.cp_colorPk.color = this._aColors[index];
                };
            };
        }

        private function updateDirection(direction:int):void
        {
            var e:EntityDisplayer;
            if (((((direction % 2) == 0)) && ((this.edChara.animation == "AnimAttaque0"))))
            {
                this._direction = ((direction + 1) % 8);
            }
            else
            {
                this._direction = direction;
            };
            this.edChara.direction = this._direction;
            for each (e in this._randomColorEntityDisplayers)
            {
                e.direction = this._direction;
            };
        }

        private function updateRandomColorLook():void
        {
            var i:int;
            var j:int;
            var colorArray:Array;
            i = 0;
            while (i <= COLOR_GENERATION_METHODE_NUMBER)
            {
                if (((this._randomColorEntityDisplayers[i]) && (this.edChara.look)))
                {
                    this._randomColorEntityDisplayers[i].look.updateFrom(this.edChara.look);
                    colorArray = this._randomLookColors[this._randomColorPage][i];
                    j = 0;
                    while (j < colorArray.length)
                    {
                        this._randomColorEntityDisplayers[i].setColor((j + 1), colorArray[j]);
                        j++;
                    };
                };
                this._randomColorEntityDisplayers[i].updateMask();
                i++;
            };
        }

        private function displayEquipment(lookStr:String=""):void
        {
            var i:int;
            var skinsWithoutEquipment:String;
            if (this._equipmentSkinsStr == "")
            {
                if (lookStr != "")
                {
                    this.edChara.look = lookStr;
                };
                return;
            };
            var look:String = ((!((lookStr == ""))) ? lookStr : this.edChara.look.toString());
            var lookStrParts:Array = look.split("|");
            if (this.btn_showEquipment.selected)
            {
                if (lookStrParts[1].indexOf(this._equipmentSkinsStr) != -1)
                {
                    return;
                };
                look = ((((lookStrParts[0] + "|") + lookStrParts[1]) + ",") + this._equipmentSkinsStr);
                i = 2;
                while (i < lookStrParts.length)
                {
                    look = (look + ("|" + lookStrParts[i]));
                    i++;
                };
            }
            else
            {
                skinsWithoutEquipment = lookStrParts[1].toString().replace(("," + this._equipmentSkinsStr), "");
                look = ((lookStrParts[0] + "|") + skinsWithoutEquipment);
                i = 2;
                while (i < lookStrParts.length)
                {
                    look = (look + ("|" + lookStrParts[i]));
                    i++;
                };
            };
            this.edChara.look = look;
        }

        public function lockCreation():void
        {
            this.btn_create.disabled = true;
        }

        public function onRelease(target:Object):void
        {
            var _local_2:uint;
            switch (target)
            {
                case this.edChara:
                    break;
                case this.btn_generateName:
                    if (!(this._bRequestCreation))
                    {
                        this.sysApi.sendAction(new CharacterNameSuggestionRequest());
                    };
                    break;
                case this.btn_generateColor:
                    if (this._randomLookColors.length < 100)
                    {
                        this.generateColors();
                    }
                    else
                    {
                        this.changeRandomPage(0);
                    };
                    if (this._aColors[this._selectedSlot] != -1)
                    {
                        this.cp_colorPk.color = this._aColors[this._selectedSlot];
                    };
                    break;
                case this.btn_reinitColor:
                    this.resetColor();
                    if (this._aColors[this._selectedSlot] != -1)
                    {
                        this.cp_colorPk.color = this._aColors[this._selectedSlot];
                    };
                    break;
                case this.btn_leftArrow:
                    this.wheelChara(1);
                    break;
                case this.btn_rightArrow:
                    this.wheelChara(-1);
                    break;
                case this.btn_sex0:
                    if (this._gender != 0)
                    {
                        this._direction = 3;
                        this.updateGender(0, true);
                    };
                    break;
                case this.btn_sex1:
                    if (this._gender != 1)
                    {
                        this._direction = 3;
                        this.updateGender(1, true);
                    };
                    break;
                case this.btn_color0:
                    this.pickColor(0);
                    break;
                case this.btn_color1:
                    this.pickColor(1);
                    break;
                case this.btn_color2:
                    this.pickColor(2);
                    break;
                case this.btn_color3:
                    this.pickColor(3);
                    break;
                case this.btn_color4:
                    this.pickColor(4);
                    break;
                case this.btn_reinitColor0:
                    this.resetColor(0);
                    break;
                case this.btn_reinitColor1:
                    this.resetColor(1);
                    break;
                case this.btn_reinitColor2:
                    this.resetColor(2);
                    break;
                case this.btn_reinitColor3:
                    this.resetColor(3);
                    break;
                case this.btn_reinitColor4:
                    this.resetColor(4);
                    break;
                case this.btn_hexaOk:
                    _local_2 = int(Number(("0x" + this.inp_hexaValue.text)));
                    this.onColorChange(new Object(), _local_2);
                    this.cp_colorPk.color = _local_2;
                    break;
                case this.btn_breedInfo:
                    this.ctr_breedInfos.visible = !(this.ctr_breedInfos.visible);
                    break;
                case this.btn_infoClose:
                    this.texta_breedInfo.visible = true;
                    this.gd_spells.visible = true;
                    this.ctr_breedInfos.visible = false;
                    this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
                    break;
                case this.btn_undo:
                    this.sysApi.sendAction(new CharacterDeselection());
                    Connection.getInstance().openPreviousUi();
                    break;
                case this.btn_create:
                    if (!(this._bRequestCreation))
                    {
                        this._bRequestCreation = true;
                        this.createCharacter();
                    };
                    break;
                case this.btn_randomLeft:
                    if ((((this._randomColorPage == 0)) && ((this._randomLookColors.length < 100))))
                    {
                        this.generateColors();
                    }
                    else
                    {
                        this.changeRandomPage((this._randomColorPage - 1));
                    };
                    break;
                case this.btn_randomRight:
                    if ((this._randomLookColors.length - 1) > this._randomColorPage)
                    {
                        this.changeRandomPage((this._randomColorPage + 1));
                    }
                    else
                    {
                        this.generateColors();
                    };
                    break;
                case this.btn_showEquipment:
                    this.displayEquipment();
                    this.onRollOver(target);
                    break;
            };
        }

        public function onDoubleClick(target:Object):void
        {
            switch (target)
            {
                case this.btn_leftArrow:
                    this.wheelChara(1);
                    break;
                case this.btn_rightArrow:
                    this.wheelChara(-1);
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var numBreed:int;
            var textkey:String;
            var breed:Object;
            var i:int;
            if (selectMethod != GridItemSelectMethodEnum.AUTO)
            {
                if (target == this.gd_breed)
                {
                    this._breedIndex = this.gd_breed.selectedIndex;
                    this._direction = 3;
                    breed = this._aBreeds[this._breedIndex];
                    if (!(breed))
                    {
                        return;
                    };
                    numBreed = breed.id;
                    if ((((this._activeModules.indexOf(TYPE_CREATE) == -1)) || ((((Connection.BREEDS_AVAILABLE > 0)) && (((Math.pow(2, (numBreed - 1)) & Connection.BREEDS_AVAILABLE) > 0))))))
                    {
                        if (((numBreed) && (!((numBreed == this._breed)))))
                        {
                            this._breed = numBreed;
                            this.displayBreed();
                            if (this.ctr_randomColor.visible)
                            {
                                this.ctr_randomColor.visible = false;
                                this.ctr_colors.y = this._yColorsDown;
                            };
                        };
                    }
                    else
                    {
                        textkey = "ui.charcrea.breedNotAvailable";
                        if ((((((numBreed == 12)) || ((numBreed == 13)))) || ((numBreed == 14))))
                        {
                            textkey = (textkey + ("." + numBreed));
                        };
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText(textkey), [this.uiApi.getText("ui.common.ok")], null, null, null, null, false, true);
                        this.gd_breed.selectedIndex = 0;
                    };
                }
                else
                {
                    if (target == this.gd_heads)
                    {
                        this._head = this.gd_heads.selectedItem.id;
                        this.displayCharacter();
                    }
                    else
                    {
                        if (target == this.gd_randomColorPreview)
                        {
                            this._aColors = this._randomLookColors[this._randomColorPage][this.gd_randomColorPreview.selectedIndex].concat();
                            i = 0;
                            while (i < this._aTx_color.length)
                            {
                                this.changeColor(this._aTx_color[i], this._aColors[i]);
                                i++;
                            };
                            this.colorizeCharacter();
                        };
                    };
                };
            };
        }

        public function onEntityReady(target:Object):void
        {
            var i:int;
            if (!(this._randomInitialized))
            {
                i = 0;
                while (i < this._randomColorEntityDisplayers.length)
                {
                    this._randomColorEntityDisplayers[i].direction = this._direction;
                    this._randomColorEntityDisplayers[i].look = this.edChara.look;
                    i++;
                };
                this._randomInitialized = true;
            }
            else
            {
                if (this._randomColorPage >= 0)
                {
                    this.updateRandomColorLook();
                };
                if (this._activeModules.indexOf(TYPE_RECOLOR) != -1)
                {
                    this.colorizeCharacter();
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
                this.uiApi.showTooltip(item.data, item.container, false, "standard", LocationEnum.POINT_BOTTOMRIGHT);
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            switch (target)
            {
                case this.tx_nameRules:
                    text = this.uiApi.getText("ui.charcrea.nameRules");
                    break;
                case this.btn_sex0:
                    text = this.uiApi.getText("ui.tooltip.male");
                    break;
                case this.btn_sex1:
                    text = this.uiApi.getText("ui.tooltip.female");
                    break;
                case this.btn_color0:
                    this._overSlot = 0;
                    this.sysApi.addEventListener(this.onEnterFrame, "time");
                    break;
                case this.btn_color1:
                    this._overSlot = 1;
                    this.sysApi.addEventListener(this.onEnterFrame, "time");
                    break;
                case this.btn_color2:
                    this._overSlot = 2;
                    this.sysApi.addEventListener(this.onEnterFrame, "time");
                    break;
                case this.btn_color3:
                    this._overSlot = 3;
                    this.sysApi.addEventListener(this.onEnterFrame, "time");
                    break;
                case this.btn_color4:
                    this._overSlot = 4;
                    this.sysApi.addEventListener(this.onEnterFrame, "time");
                    break;
                case this.btn_showEquipment:
                    if (this.btn_showEquipment.selected)
                    {
                        text = this.uiApi.getText("ui.charcrea.hideStuff");
                    }
                    else
                    {
                        if (this.btn_showEquipment.softDisabled)
                        {
                            text = this.uiApi.getText("ui.charcrea.cannotshowstuff");
                        }
                        else
                        {
                            text = this.uiApi.getText("ui.charcrea.showStuff");
                        };
                    };
                    break;
                default:
                    if (target.name.indexOf("btn_head") != -1)
                    {
                        if (this._componentsList[target.name])
                        {
                            text = ((this.uiApi.getText("ui.charcrea.face") + " ") + this._componentsList[target.name].label);
                        };
                    };
                    if (target.name.indexOf("ctr_breed") != -1)
                    {
                        if (this._componentsList[target.name])
                        {
                            text = this._componentsList[target.name].shortName;
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("ctr_roleItem") != -1)
                        {
                            if (this._componentsList[target.name])
                            {
                                text = this._componentsList[target.name].description;
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("lbl_role") != -1)
                            {
                                if (this._componentsList[target.name])
                                {
                                    text = this._aRoles[this._componentsList[target.name].id].description;
                                };
                            }
                            else
                            {
                                if (target.name.indexOf("btn_randomLook") != -1)
                                {
                                    if (this._componentsList[target.name])
                                    {
                                        text = this.uiApi.getText("ui.charcrea.clickCharToColor");
                                    };
                                };
                            };
                        };
                    };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onColorChange(target:Object, fixedColor:int=-1):void
        {
            var color:uint;
            if (((!(this.ctr_hexaColor.visible)) || ((fixedColor == -1))))
            {
                color = this.cp_colorPk.color;
            }
            else
            {
                color = fixedColor;
            };
            this.ctr_hexaColor.visible = false;
            var selectedItem:Object = this.uiApi.getRadioGroupSelectedItem("colorGroup", this.uiApi.me());
            switch (selectedItem.name)
            {
                case this.btn_color0.name:
                    this._aColors[0] = color;
                    this.changeColor(this.tx_color0, color);
                    break;
                case this.btn_color1.name:
                    this._aColors[1] = color;
                    this.changeColor(this.tx_color1, color);
                    break;
                case this.btn_color2.name:
                    this._aColors[2] = color;
                    this.changeColor(this.tx_color2, color);
                    break;
                case this.btn_color3.name:
                    this._aColors[3] = color;
                    this.changeColor(this.tx_color3, color);
                    break;
                case this.btn_color4.name:
                    this._aColors[4] = color;
                    this.changeColor(this.tx_color4, color);
                    break;
            };
            this.colorizeCharacter();
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
            this.sysApi.removeEventListener(this.onEnterFrame);
            if ((((((((((target == this.btn_color0)) || ((target == this.btn_color1)))) || ((target == this.btn_color2)))) || ((target == this.btn_color3)))) || ((target == this.btn_color4))))
            {
                if (this._aColors[this._overSlot] != -1)
                {
                    this.edChara.setColor((this._overSlot + 1), this._aColors[this._overSlot]);
                }
                else
                {
                    this.edChara.setColor((this._overSlot + 1), this._aColorsBase[this._overSlot]);
                };
            };
        }

        public function onShortcut(s:String):Boolean
        {
            var color:uint;
            switch (s)
            {
                case "validUi":
                    if (this.ctr_hexaColor.visible)
                    {
                        color = int(Number(("0x" + this.inp_hexaValue.text)));
                        this.onColorChange(new Object(), color);
                        this.cp_colorPk.color = color;
                    }
                    else
                    {
                        if (!(this._bRequestCreation))
                        {
                            this._bRequestCreation = true;
                            this.createCharacter();
                        };
                    };
                    return (true);
                case "closeUi":
                    if (this.ctr_hexaColor.visible)
                    {
                        this.ctr_hexaColor.visible = false;
                        return (true);
                    };
            };
            return (false);
        }

        public function onCharacterCreationResult(result:int):void
        {
            if (result > 0)
            {
                switch (result)
                {
                    case CharacterCreationResultEnum.ERR_INVALID_NAME:
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.popup.charcrea.invalidName"), [this.uiApi.getText("ui.common.ok")]);
                        break;
                    case CharacterCreationResultEnum.ERR_NAME_ALREADY_EXISTS:
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.popup.charcrea.nameAlreadyExist"), [this.uiApi.getText("ui.common.ok")]);
                        this.sysApi.log(16, "Ce nom existe deja.");
                        break;
                    case CharacterCreationResultEnum.ERR_NOT_ALLOWED:
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.popup.charcrea.notSubscriber"), [this.uiApi.getText("ui.common.ok")]);
                        this.sysApi.log(16, "Seuls les abonnés peuvent jouer cette classe de personnage.");
                        break;
                    case CharacterCreationResultEnum.ERR_TOO_MANY_CHARACTERS:
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.popup.charcrea.tooManyCharacters"), [this.uiApi.getText("ui.common.ok")]);
                        this.sysApi.log(16, "Vous avez deja trop de personnages");
                        break;
                    case CharacterCreationResultEnum.ERR_NO_REASON:
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.popup.charcrea.noReason"), [this.uiApi.getText("ui.common.ok")]);
                        this.sysApi.log(16, "Echec sans raison");
                        break;
                    case CharacterCreationResultEnum.ERR_RESTRICED_ZONE:
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.charSel.deletionErrorUnsecureMode"), [this.uiApi.getText("ui.common.ok")]);
                        this.sysApi.log(16, "Vous ne pouvez pas créer de personnage en mode Unsecure");
                        break;
                };
            }
            else
            {
                this.soundApi.playLookSound(this._currentLook, LookTypeSoundEnum.CHARACTER_SELECTION);
                Connection.TUTORIAL_SELECTION = true;
            };
            this._bRequestCreation = false;
            this.btn_create.disabled = false;
            this.btn_generateName.disabled = false;
        }

        public function onCharacterImpossibleSelection(pCharacterId:uint):void
        {
            this._bRequestCreation = false;
            this.btn_create.disabled = false;
            this.btn_generateName.disabled = false;
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.impossible_action"), this.uiApi.getText("ui.common.cantSelectThisCharacter"), [this.uiApi.getText("ui.common.ok")]);
        }

        public function onCharacterNameSuggestioned(characterName:String):void
        {
            this.input_name.text = characterName;
        }

        public function onInput(te:Object):void
        {
            if (((!((this._lang == "ru"))) && (!((this._lang == "ja")))))
            {
                if (this.input_name.text.length == 1)
                {
                    this.input_name.text = this.input_name.text.toLocaleUpperCase();
                };
            };
        }

        public function onChange(target:Object):void
        {
            if (target == this.input_name)
            {
                if (((!((this.lbl_name.text == ""))) && (!((this.input_name.text == "")))))
                {
                    this.lbl_name.text = "";
                };
                if ((((this.lbl_name.text == "")) && ((this.input_name.text == ""))))
                {
                    this.lbl_name.text = this.uiApi.getText("ui.charcrea.titleRename");
                };
            };
        }

        public function onEnterFrame():void
        {
            this._frameCount++;
            if (this._frameCount > 4)
            {
                this.edChara.setColor((this._overSlot + 1), 0xFFBB00);
                this._frameCount = 0;
            }
            else
            {
                if (this._frameCount > 2)
                {
                    this.edChara.setColor((this._overSlot + 1), 0xFFFF00);
                };
            };
        }

        private function getColorByXYSlideX(x:Number, y:Number, slideY:Number):uint
        {
            var r1:Number;
            var g1:Number;
            var b1:Number;
            var r2:Number;
            var g2:Number;
            var b2:Number;
            var nGradientColor:uint = this.getGradientColor(x, y);
            var colorPoint:Number = (0xFF - ((slideY / 100) * 510));
            var color:uint;
            r1 = ((nGradientColor & 0xFF0000) >> 16);
            g1 = ((nGradientColor & 0xFF00) >> 8);
            b1 = (nGradientColor & 0xFF);
            if (colorPoint >= 0)
            {
                r2 = (((colorPoint * (0xFF - r1)) / 0xFF) + r1);
                g2 = (((colorPoint * (0xFF - g1)) / 0xFF) + g1);
                b2 = (((colorPoint * (0xFF - b1)) / 0xFF) + b1);
            }
            else
            {
                colorPoint = (colorPoint * -1);
                r2 = Math.round((r1 - ((r1 * colorPoint) / 0xFF)));
                g2 = Math.round((g1 - ((g1 * colorPoint) / 0xFF)));
                b2 = Math.round((b1 - ((b1 * colorPoint) / 0xFF)));
            };
            color = Math.round((((r2 << 16) + (g2 << 8)) + b2));
            return (color);
        }

        private function getGradientColor(x:Number, y:Number):uint
        {
            var colorPoint1:Number;
            var colorPoint2:Number;
            var r1:Number;
            var g1:Number;
            var b1:Number;
            var r2:Number;
            var g2:Number;
            var b2:Number;
            var c1:Number;
            var c2:Number;
            var r:Number;
            var g:Number;
            var b:Number;
            var gradientColor:uint;
            var aColorsHue:Array = new Array(0xFF0000, 0xFFFF00, 0xFF00, 0xFFFF, 0xFF, 0xFF00FF, 0xFF0000);
            var aRatiosHue:Array = new Array(0, ((1 * 0xFF) / 6), ((2 * 0xFF) / 6), ((3 * 0xFF) / 6), ((4 * 0xFF) / 6), ((5 * 0xFF) / 6), 0xFF);
            var gradientWidth:Number = 1000;
            var gradientHeight:Number = 1000;
            if (x >= gradientWidth)
            {
                x = (gradientWidth - 1);
            };
            colorPoint1 = (x / gradientWidth);
            var i:Number = Math.floor((colorPoint1 * (aRatiosHue.length - 1)));
            colorPoint1 = (colorPoint1 * 0xFF);
            colorPoint2 = (0xFF - (((aRatiosHue[(i + 1)] - colorPoint1) / (aRatiosHue[(i + 1)] - aRatiosHue[i])) * 0xFF));
            c1 = aColorsHue[i];
            c2 = aColorsHue[(i + 1)];
            r1 = (c1 & 0xFF0000);
            g1 = (c1 & 0xFF00);
            b1 = (c1 & 0xFF);
            r2 = (c2 & 0xFF0000);
            g2 = (c2 & 0xFF00);
            b2 = (c2 & 0xFF);
            if (r1 != r2)
            {
                r = Math.round((((r1)>r2) ? (0xFF - colorPoint2) : colorPoint2));
            }
            else
            {
                r = (r1 >> 16);
            };
            if (g1 != g2)
            {
                g = Math.round((((g1)>g2) ? (0xFF - colorPoint2) : colorPoint2));
            }
            else
            {
                g = (g1 >> 8);
            };
            if (b1 != b2)
            {
                b = Math.round((((b1)>b2) ? (0xFF - colorPoint2) : colorPoint2));
            }
            else
            {
                b = b1;
            };
            colorPoint1 = ((y / gradientHeight) * 0xFF);
            r = (r + (((127 - r) * colorPoint1) / 0xFF));
            g = (g + (((127 - g) * colorPoint1) / 0xFF));
            b = (b + (((127 - b) * colorPoint1) / 0xFF));
            gradientColor = Math.round((((r << 16) + (g << 8)) + b));
            return (gradientColor);
        }


    }
}//package ui

