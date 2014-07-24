package ui
{
   import d2api.SystemApi;
   import d2api.DataApi;
   import d2api.UiApi;
   import d2api.MountApi;
   import d2api.ColorApi;
   import d2api.SoundApi;
   import flash.utils.Dictionary;
   import d2components.GraphicContainer;
   import d2components.Grid;
   import d2components.Texture;
   import d2components.ButtonContainer;
   import d2components.EntityDisplayer;
   import d2components.ColorPicker;
   import d2components.Input;
   import d2components.Label;
   import d2components.TextArea;
   import d2data.Breed;
   import d2data.Head;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.ProtocolConstantsEnum;
   import flash.events.TextEvent;
   import flash.geom.ColorTransform;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   import d2enums.LocationEnum;
   import d2enums.CharacterCreationResultEnum;
   import com.ankamagames.dofusModuleLibrary.enum.LookTypeSoundEnum;
   
   public class CharacterCreation extends Object
   {
      
      public function CharacterCreation() {
         this._dataHeadList = new Dictionary(true);
         this._randomLookColors = new Array();
         this._randomColorEntityDisplayers = new Array();
         super();
      }
      
      public static const COLOR_GENERATION_METHODE_NUMBER:int = 5;
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var dataApi:DataApi;
      
      public var uiApi:UiApi;
      
      public var mountApi:MountApi;
      
      public var colorApi:ColorApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      private var _lang:String;
      
      private var _hasRights:Boolean = false;
      
      private var _mode:String = "create";
      
      private var _charaId:int;
      
      private var _assetsUri:String;
      
      private var _bRequestCreation:Boolean = false;
      
      private var _aColors:Array;
      
      private var _aColorsBase:Object;
      
      private var _look:Object;
      
      private var _noStuffLook:Object;
      
      private var _gender:int;
      
      private var _breed:int;
      
      private var _name:String;
      
      private var _head:int;
      
      private var _direction:int = 3;
      
      private var _aBreeds:Array;
      
      private var _aGenders:Array;
      
      private var _aHeads:Array;
      
      private var _dataHeadList:Dictionary;
      
      private var _breedIndex:int;
      
      private var _aTx_color:Array;
      
      private var _selectedSlot:uint;
      
      private var _overSlot:uint;
      
      private var _frameCount:uint = 0;
      
      private var _aAnim:Array;
      
      private var _currentLook:String;
      
      private var _randomLookColors:Array;
      
      private var _randomColorEntityDisplayers:Array;
      
      private var _randomColorPage:int = -1;
      
      private var _randomInitialized:Boolean = false;
      
      public var creaCtr:GraphicContainer;
      
      public var ctr_info:GraphicContainer;
      
      public var gd_breed:Grid;
      
      public var gd_heads:Grid;
      
      public var gd_randomColorPrevisualisation:Grid;
      
      public var tx_randomColorBg:Texture;
      
      public var btn_randomRight:ButtonContainer;
      
      public var btn_randomLeft:ButtonContainer;
      
      public var tx_breedSymbol:Texture;
      
      public var tx_base:Texture;
      
      public var edChara:EntityDisplayer;
      
      public var tx_artwork:Texture;
      
      public var tx_bgBreed:Texture;
      
      public var tx_bgColors:Texture;
      
      public var tx_bgHeads:Texture;
      
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
      
      public var lbl_name:Input;
      
      public var tx_name:Texture;
      
      public var tx_nameRules:Texture;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
      public var btn_showEquipment:ButtonContainer;
      
      public var btn_spell:ButtonContainer;
      
      public var btn_more:ButtonContainer;
      
      public var btn_infoClose:ButtonContainer;
      
      public var btn_reinitColor:ButtonContainer;
      
      public var btn_generateColor:ButtonContainer;
      
      public var btn_generateName:ButtonContainer;
      
      public var btn_undo:ButtonContainer;
      
      public var btn_create:ButtonContainer;
      
      public var btn_lbl_btn_create:Label;
      
      public var lbl_titleCreation:Label;
      
      public var lbl_breed:Label;
      
      public var lbl_breedTitle:Label;
      
      public var lbl_colorTitle:Label;
      
      public var lbl_infoTitle:Label;
      
      public var texta_breedInfo:TextArea;
      
      public var gd_spells:Grid;
      
      public var ctr_hexaColor:GraphicContainer;
      
      public var inp_hexaValue:Input;
      
      public var btn_hexaOk:ButtonContainer;
      
      public function main(params:Object = null) : void {
         var breed:Breed = null;
         var head:Head = null;
         var colorI:* = undefined;
         var lookArray:Array = null;
         var breedGenderHeads:Array = null;
         var index:* = 0;
         var lookArrayRename:Array = null;
         var breedtemp:* = 0;
         var clrId:* = undefined;
         var i:* = 0;
         var head3:Head = null;
         var head2:Head = null;
         var j:* = 0;
         this.ctr_info.visible = false;
         this.ctr_hexaColor.visible = false;
         this.texta_breedInfo.hideScroll = true;
         this.gd_randomColorPrevisualisation.visible = false;
         this.tx_randomColorBg.visible = false;
         this.btn_randomLeft.visible = false;
         this.btn_randomRight.visible = false;
         this.btn_leftArrow.soundId = SoundEnum.SCROLL_DOWN;
         this.btn_rightArrow.soundId = SoundEnum.SCROLL_UP;
         this.btn_sex1.soundId = SoundEnum.CHECKBOX_CHECKED;
         this.btn_sex0.soundId = SoundEnum.CHECKBOX_UNCHECKED;
         this.btn_spell.soundId = SoundEnum.SPEC_BUTTON;
         this.btn_more.soundId = SoundEnum.SPEC_BUTTON;
         this.btn_undo.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_infoClose.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_showEquipment.visible = false;
         this.sysApi.addHook(CharacterCreationResult,this.onCharacterCreationResult);
         this.sysApi.addHook(CharacterNameSuggestioned,this.onCharacterNameSuggestioned);
         this.sysApi.addHook(CharacterImpossibleSelection,this.onCharacterImpossibleSelection);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.tx_nameRules,"onRollOver");
         this.uiApi.addComponentHook(this.tx_nameRules,"onRollOut");
         this.uiApi.addComponentHook(this.btn_showEquipment,"onRollOver");
         this.uiApi.addComponentHook(this.btn_showEquipment,"onRollOut");
         this.uiApi.addComponentHook(this.edChara,"onRelease");
         this.uiApi.addComponentHook(this.edChara,"onEntityReady");
         this.uiApi.addComponentHook(this.gd_randomColorPrevisualisation,ComponentHookList.ON_SELECT_ITEM);
         if(params)
         {
            this._mode = params[0];
         }
         else
         {
            this._mode = "create";
         }
         if(this._mode == "create")
         {
            this.btn_lbl_btn_create.text = this.uiApi.getText("ui.charcrea.create");
         }
         else
         {
            this.btn_lbl_btn_create.text = this.uiApi.getText("ui.common.validation");
         }
         this._assetsUri = this.uiApi.me().getConstant("breedUri");
         this.lbl_name.maxChars = ProtocolConstantsEnum.MAX_PLAYER_NAME_LEN - 1;
         this._lang = this.sysApi.getCurrentLanguage();
         this._hasRights = this.sysApi.getPlayerManager().hasRights;
         if(!this._hasRights)
         {
            switch(this._lang)
            {
               case "ru":
                  this.lbl_name.restrict = "^ ";
                  break;
               case "ja":
                  this.lbl_name.restrict = "[ァ-ヾぁ-ゞA-Za-z\\-]+";
                  break;
               case "fr":
               case "en":
               case "es":
               case "de":
               case "it":
               case "nl":
               case "pt":
               default:
                  this.lbl_name.restrict = "A-Z\\-a-z";
            }
         }
         this._aTx_color = new Array(this.tx_color0,this.tx_color1,this.tx_color2,this.tx_color3,this.tx_color4);
         this._aBreeds = new Array();
         for each(breed in this.dataApi.getBreeds())
         {
            if((Math.pow(2,breed.id - 1) & Connection.BREEDS_VISIBLE) > 0)
            {
               this._aBreeds.push(breed);
            }
         }
         this.gd_breed.dataProvider = this._aBreeds;
         this._aHeads = new Array();
         for each(head in this.dataApi.getHeads())
         {
            this._aHeads.push(head);
         }
         this._aGenders = new Array(this.btn_sex0,this.btn_sex1);
         switch(this._mode)
         {
            case "recolor":
               this.btn_showEquipment.visible = true;
               this.btn_showEquipment.selected = true;
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.connection.recolor"),[this.uiApi.getText("ui.common.ok")]);
               this._charaId = params[1].id;
               this._aColors = new Array(-1,-1,-1,-1,-1);
               for(clrId in params[2])
               {
                  this._aColors[clrId] = params[2][clrId];
               }
               this._gender = params[1].sex;
               this._name = params[1].name;
               this._look = this.mountApi.getRiderEntityLook(params[1].entityLook);
               if(this._look.getBone() != 1)
               {
                  this._look = null;
               }
               this.lbl_name.text = this._name;
               this.lbl_titleCreation.text = this.uiApi.getText("ui.charcrea.titleRecolor");
               this.gd_breed.selectedIndex = params[1].breedId - 1;
               break;
            case "relook":
               this.btn_showEquipment.visible = true;
               this.btn_showEquipment.selected = true;
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.connection.relook"),[this.uiApi.getText("ui.common.ok")]);
               this._charaId = params[1].id;
               this._aColors = new Array(-1,-1,-1,-1,-1);
               this._gender = params[1].sex;
               this._name = params[1].name;
               this._breed = params[1].breedId;
               this._look = this.mountApi.getRiderEntityLook(params[1].entityLook);
               this._head = params[2];
               this.edChara.clearSubEntities = false;
               lookArray = this._look.getColors(true);
               if(lookArray)
               {
                  i = 0;
                  while(i < 5)
                  {
                     if(lookArray[i + 1] != null)
                     {
                        this._aColors[i] = lookArray[i + 1];
                     }
                     i++;
                  }
               }
               this.lbl_name.text = this._name;
               this.lbl_titleCreation.text = this.uiApi.getText("ui.charcrea.titleRelook");
               this.gd_breed.selectedIndex = this._breed - 1;
               this._breedIndex = this._breed - 1;
               this.displayBreed();
               breedGenderHeads = new Array();
               for each(head3 in this._aHeads)
               {
                  if((head3.breed == this._breed) && (head3.gender == this._gender))
                  {
                     breedGenderHeads.push(head3);
                  }
               }
               breedGenderHeads.sortOn("order",Array.NUMERIC);
               this.gd_heads.dataProvider = breedGenderHeads;
               index = 0;
               for each(head2 in this.gd_heads.dataProvider)
               {
                  if(head2.id == this._head)
                  {
                     this.gd_heads.selectedIndex = index;
                     break;
                  }
                  index++;
               }
               break;
            case "rename":
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.connection.rename"),[this.uiApi.getText("ui.common.ok")]);
               this._charaId = params[1].id;
               this._aColors = new Array(-1,-1,-1,-1,-1);
               this._gender = params[1].sex;
               this._name = params[1].name;
               this._look = this.mountApi.getRiderEntityLook(params[1].entityLook);
               this.edChara.clearSubEntities = false;
               lookArrayRename = this._look.getColors(true);
               if(lookArrayRename)
               {
                  j = 0;
                  while(j < 5)
                  {
                     if(lookArrayRename[j + 1] != null)
                     {
                        this._aColors[j] = lookArrayRename[j + 1];
                     }
                     j++;
                  }
               }
               this.lbl_name.text = this._name;
               this.lbl_titleCreation.text = this.uiApi.getText("ui.charcrea.titleRename");
               this.lbl_name.textfield.addEventListener(TextEvent.TEXT_INPUT,this.onInput);
               this.gd_breed.selectedIndex = params[1].breedId - 1;
               break;
            case "create":
               this._aColors = new Array(-1,-1,-1,-1,-1);
               breedtemp = -1;
               this._gender = Math.round(Math.random());
               if(Connection.BREEDS_AVAILABLE > 0)
               {
                  do
                  {
                     breedtemp = Math.floor(Math.random() * this._aBreeds.length);
                  }
                  while((Math.pow(2,this._aBreeds[breedtemp].id - 1) & Connection.BREEDS_AVAILABLE) <= 0);
                  
                  this.gd_breed.selectedIndex = breedtemp;
               }
               else
               {
                  this.gd_breed.selectedIndex = -1;
               }
               this.gd_heads.selectedIndex = 0;
               this.lbl_name.textfield.addEventListener(TextEvent.TEXT_INPUT,this.onInput);
               break;
         }
         for(colorI in this._aColors)
         {
            if(this._aTx_color[colorI])
            {
               this.changeColor(this._aTx_color[colorI],this._aColors[colorI]);
            }
         }
         this.gd_randomColorPrevisualisation.dataProvider = new Array(-1,-1,-1,-1,-1,-1);
         this.uiApi.setRadioGroupSelectedItem("colorGroup",this.btn_color0,this.uiApi.me());
         this._aAnim = new Array("AnimStatique","AnimMarche","AnimCourse","AnimAttaque0");
         this.switchMode();
      }
      
      public function unload() : void {
         this.lbl_name.textfield.removeEventListener(TextEvent.TEXT_INPUT,this.onInput);
      }
      
      private function displayCharacter() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function colorizeCharacter() : void {
         var color:* = undefined;
         for(color in this._aColors)
         {
            if(this._aColors[color] != -1)
            {
               this.edChara.setColor(color + 1,this._aColors[color]);
            }
            else if(this._aColorsBase.length > color)
            {
               this.edChara.setColor(color + 1,this._aColorsBase[color]);
            }
            
         }
      }
      
      private function generateColors() : void {
         var generatedColor:* = undefined;
         var i:* = 0;
         var tempArray:Array = null;
         var j:* = 0;
         if(!this.gd_randomColorPrevisualisation.visible)
         {
            this.gd_randomColorPrevisualisation.visible = true;
            this.tx_randomColorBg.visible = true;
            this.tx_artwork.visible = false;
            this.gd_randomColorPrevisualisation.disabled = false;
            this.btn_randomLeft.visible = true;
            this.btn_randomRight.visible = true;
         }
         var x:int = 0;
         var y:int = 0;
         var slide:int = 0;
         switch(this._breed)
         {
            case 12:
               y = Math.random() * 750 + 250;
               if(y > 750)
               {
                  x = Math.random() * 1000;
               }
               else
               {
                  x = Math.random() * 90 + 50;
               }
               slide = Math.random() * 100;
               break;
            case 6:
               x = Math.random() * 140 + 25;
               y = Math.random() * 700 + 200;
               slide = Math.random() * 80 + 10;
               break;
            default:
               x = Math.random() * 90 + 50;
               y = Math.random() * 650 + 250;
               slide = Math.random() * 80 + 10;
         }
         var color:uint = this.getColorByXYSlideX(x,y,slide);
         var pageArray:Array = new Array();
         i = 0;
         while(i <= COLOR_GENERATION_METHODE_NUMBER)
         {
            tempArray = new Array();
            tempArray[0] = color;
            generatedColor = this.colorApi.generateColorList(i);
            j = 0;
            while(j < generatedColor.length)
            {
               tempArray[j + 1] = generatedColor[j];
               j++;
            }
            pageArray.push(tempArray);
            i++;
         }
         this._randomLookColors.push(pageArray);
         this._randomColorPage = this._randomLookColors.length - 1;
         this.updateRandomColorLook();
      }
      
      public function updatePrevisualisationLine(data:*, componentsRef:*, selected:Boolean) : void {
         if((data) && (this._randomColorEntityDisplayers.length <= 6))
         {
            this._randomColorEntityDisplayers.push(componentsRef.charaPrevisu);
         }
      }
      
      private function changeRandomPage(pageNumber:int) : void {
         if(pageNumber == 99)
         {
            pageNumber = 0;
         }
         else if(pageNumber == -1)
         {
            pageNumber = 99;
         }
         
         this._randomColorPage = pageNumber;
         this.updateRandomColorLook();
      }
      
      public function updateBreed(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            if(data.id < 10)
            {
               componentsRef.tx_breed.uri = this.uiApi.createUri(this.uiApi.me().getConstant("breed_uri") + "assets.swf|CreaPerso_btn_" + this._gender + "0" + data.id);
            }
            else
            {
               componentsRef.tx_breed.uri = this.uiApi.createUri(this.uiApi.me().getConstant("breed_uri") + "assets.swf|CreaPerso_btn_" + this._gender + "" + data.id);
            }
            if(selected)
            {
               componentsRef.tx_selected.visible = true;
            }
            else
            {
               componentsRef.tx_selected.visible = false;
            }
            if((Connection.BREEDS_AVAILABLE > 0) && ((Math.pow(2,data.id - 1) & Connection.BREEDS_AVAILABLE) > 0))
            {
               componentsRef.tx_grey.visible = false;
            }
            else
            {
               componentsRef.tx_grey.visible = true;
            }
         }
      }
      
      public function updateHead(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.tx_head.uri = this.uiApi.createUri(this.uiApi.me().getConstant("heads_uri") + data.assetId + ".png");
            if(selected)
            {
               componentsRef.tx_hselected.visible = true;
            }
            else
            {
               componentsRef.tx_hselected.visible = false;
            }
         }
         if(!this._dataHeadList[componentsRef.btn_head.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_head,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.btn_head,ComponentHookList.ON_ROLL_OUT);
         }
         this._dataHeadList[componentsRef.btn_head.name] = data;
      }
      
      private function displayBreed() : void {
         var spells:Array = null;
         var id:* = undefined;
         this.tx_breedSymbol.gotoAndStop = this._breed.toString();
         this.updateGender(this._gender);
         if(!this._aBreeds[this._breedIndex])
         {
            this.lbl_breed.text = "?";
            this.texta_breedInfo.text = "?";
         }
         else
         {
            this.lbl_breed.text = this._aBreeds[this._breedIndex].longName;
            this.texta_breedInfo.text = this._aBreeds[this._breedIndex].description;
            spells = new Array();
            for each(id in this._aBreeds[this._breedIndex].breedSpellsId)
            {
               spells.push(this.dataApi.getSpellWrapper(id));
            }
            this.gd_spells.dataProvider = spells;
         }
      }
      
      private function updateGender(nGender:int, force:Boolean = false) : void {
         var head:Head = null;
         if((!this._aGenders[nGender].selected) || (force))
         {
            this._gender = nGender;
            this.uiApi.setRadioGroupSelectedItem("genderGroup",this._aGenders[this._gender],this.uiApi.me());
            this.gd_breed.dataProvider = this._aBreeds;
         }
         var breedGenderHeads:Array = new Array();
         for each(head in this._aHeads)
         {
            if((head.breed == this._breed) && (head.gender == this._gender))
            {
               breedGenderHeads.push(head);
            }
         }
         breedGenderHeads.sortOn("order",Array.NUMERIC);
         this._head = breedGenderHeads[0].id;
         this.gd_heads.dataProvider = breedGenderHeads;
         this.gd_heads.silent = true;
         this.gd_heads.selectedIndex = 0;
         this.gd_heads.silent = false;
         this.displayCharacter();
      }
      
      private function createChara() : void {
         var nameError:uint = 0;
         var reason:String = null;
         this._name = this.lbl_name.text;
         if(Connection.BREEDS_AVAILABLE > 0)
         {
            if(this._name)
            {
               nameError = 0;
               if(this._hasRights)
               {
                  if(this._name.length < 2)
                  {
                     this.sysApi.log(8,this._name + " trop court");
                     nameError = 1;
                  }
               }
               else if(this._lang != "ru")
               {
                  if(this._lang != "ja")
                  {
                     nameError = this.verifName();
                  }
                  else
                  {
                     nameError = this.verifNameJa();
                  }
               }
               
               if(this._mode == "recolor")
               {
                  Connection.waitingForCharactersList = true;
                  this.lockCreation();
                  this.sysApi.sendAction(new CharacterRecolorSelection(this._charaId,this._aColors));
                  return;
               }
               if(this._mode == "relook")
               {
                  Connection.waitingForCharactersList = true;
                  this.lockCreation();
                  this.sysApi.sendAction(new CharacterRelookSelection(this._charaId,this._head));
                  return;
               }
               if(nameError == 0)
               {
                  Connection.waitingForCharactersList = true;
                  if(this._mode == "create")
                  {
                     this.lockCreation();
                     this.sysApi.sendAction(new d2actions.CharacterCreation(this._name,this._breed,!(this._gender == 0),this._aColors,this._head));
                  }
                  else if(this._mode == "rename")
                  {
                     this.lockCreation();
                     this.sysApi.sendAction(new CharacterRenameSelection(this._charaId,this._name));
                     return;
                  }
                  
               }
               else
               {
                  reason = this.uiApi.getText("ui.charcrea.invalidNameReason" + nameError);
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.invalidName") + "\n\n" + reason,[this.uiApi.getText("ui.common.ok")]);
                  this._bRequestCreation = false;
                  this.btn_create.disabled = false;
               }
            }
            else
            {
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.noName"),[this.uiApi.getText("ui.common.ok")]);
               this._bRequestCreation = false;
               this.btn_create.disabled = false;
            }
         }
      }
      
      private function changeColor(obj:Object, color:Number = 16777215) : void {
         var t:ColorTransform = null;
         if(color != -1)
         {
            t = new ColorTransform();
            t.color = color;
            obj.transform.colorTransform = t;
            obj.visible = true;
            this.edChara.setColor(this._aColors.indexOf(color),this._aColors[color]);
         }
         else
         {
            obj.visible = false;
            this.edChara.resetColor(color + 1);
         }
      }
      
      private function wheelChara(sens:int) : void {
         var dir:int = (this._direction + sens + 8) % 8;
         this.updateDirection(dir);
      }
      
      private function resetColor(colorIndex:int = -1) : void {
         var i:* = undefined;
         if(colorIndex == -1)
         {
            for(i in this._aTx_color)
            {
               this._aColors[i] = -1;
               this.changeColor(this._aTx_color[i],this._aColors[i]);
            }
         }
         else
         {
            this._aColors[colorIndex] = -1;
            this.changeColor(this._aTx_color[colorIndex],-1);
         }
         this.colorizeCharacter();
      }
      
      private function verifName() : uint {
         var part:* = undefined;
         var iCarac:* = 0;
         if(this._name.length < ProtocolConstantsEnum.MIN_PLAYER_NAME_LEN)
         {
            this.sysApi.log(8,this._name + " trop court");
            return 1;
         }
         if(this._name.length > ProtocolConstantsEnum.MAX_PLAYER_NAME_LEN)
         {
            this.sysApi.log(8,this._name + " trop long");
            return 1;
         }
         if((!(this._name.indexOf("xelor") == -1)) || (!(this._name.indexOf("iop") == -1)) || (!(this._name.indexOf("feca") == -1)) || (!(this._name.indexOf("eniripsa") == -1)) || (!(this._name.indexOf("sadida") == -1)) || (!(this._name.indexOf("ecaflip") == -1)) || (!(this._name.indexOf("enutrof") == -1)) || (!(this._name.indexOf("pandawa") == -1)) || (!(this._name.indexOf("sram") == -1)) || (!(this._name.indexOf("cra") == -1)) || (!(this._name.indexOf("osamodas") == -1)) || (!(this._name.indexOf("sacrieur") == -1)) || (!(this._name.indexOf("drop") == -1)) || (!(this._name.indexOf("mule") == -1)))
         {
            this.sysApi.log(8,this._name + " contenant un mot interdit");
            return 2;
         }
         var namePart:Array = this._name.split("-");
         if(namePart.length > 2)
         {
            this.sysApi.log(8,this._name + " contenant plus d\'un tiret");
            return 3;
         }
         if((this._name.indexOf("-") == 0) || (this._name.indexOf("-") == 1))
         {
            this.sysApi.log(8,this._name + " tiret placé en 1 ou 2");
            return 3;
         }
         if(namePart[0].charAt(0) != namePart[0].charAt(0).toUpperCase())
         {
            this.sysApi.log(8,this._name + " manque de majuscule");
            return 4;
         }
         for each(part in namePart)
         {
            iCarac = 0;
            while(iCarac < part.length)
            {
               if(part.charAt(iCarac) == part.charAt(iCarac).toUpperCase())
               {
                  if(iCarac != 0)
                  {
                     this.sysApi.log(8,this._name + " majuscule en milieu de nom");
                     return 4;
                  }
               }
               iCarac++;
            }
         }
         if((this._name.indexOf("a") == -1) && (this._name.indexOf("e") == -1) && (this._name.indexOf("i") == -1) && (this._name.indexOf("o") == -1) && (this._name.indexOf("u") == -1) && (this._name.indexOf("y") == -1))
         {
            this.sysApi.log(8,this._name + " pas de voyelles");
            return 5;
         }
         var iC:int = 0;
         while(iC < this._name.length - 2)
         {
            if(this._name.charAt(iC) == this._name.charAt(iC + 1))
            {
               if(this._name.charAt(iC) == this._name.charAt(iC + 2))
               {
                  this.sysApi.log(8,this._name + " plus de 2 lettres identiques à la suite");
                  return 6;
               }
            }
            iC++;
         }
         return 0;
      }
      
      private function verifNameJa() : uint {
         if(this._name.length < 2)
         {
            this.sysApi.log(8,this._name + " trop court");
            return 1;
         }
         if(this._name.length > 19)
         {
            this.sysApi.log(8,this._name + " trop long");
            return 1;
         }
         return 0;
      }
      
      private function switchMode() : void {
         var btn_gender:* = undefined;
         var btn_gender3:* = undefined;
         var btn_gender2:* = undefined;
         switch(this._mode)
         {
            case "create":
               break;
            case "rename":
               this.gd_breed.disabled = true;
               for each(btn_gender in this._aGenders)
               {
                  btn_gender.disabled = true;
               }
               this.gd_heads.disabled = true;
               this.btn_showEquipment.visible = false;
               this.btn_color0.disabled = true;
               this.btn_color1.disabled = true;
               this.btn_color2.disabled = true;
               this.btn_color3.disabled = true;
               this.btn_color4.disabled = true;
               this.tx_colorsDisabled.visible = true;
               this.tx_bgBreed.disabled = true;
               this.tx_bgColors.disabled = true;
               this.tx_bgHeads.disabled = true;
               this.btn_reinitColor0.visible = false;
               this.btn_reinitColor1.visible = false;
               this.btn_reinitColor2.visible = false;
               this.btn_reinitColor3.visible = false;
               this.btn_reinitColor4.visible = false;
               this.cp_colorPk.disabled = true;
               this.btn_reinitColor.disabled = true;
               this.btn_generateColor.disabled = true;
               this.btn_more.disabled = true;
               this.btn_spell.disabled = true;
               break;
            case "relook":
               this.gd_breed.disabled = true;
               for each(btn_gender3 in this._aGenders)
               {
                  btn_gender3.disabled = true;
               }
               this.btn_color0.disabled = true;
               this.btn_color1.disabled = true;
               this.btn_color2.disabled = true;
               this.btn_color3.disabled = true;
               this.btn_color4.disabled = true;
               this.tx_colorsDisabled.visible = true;
               this.tx_bgBreed.disabled = true;
               this.tx_bgColors.disabled = true;
               this.tx_bgHeads.disabled = false;
               this.btn_reinitColor0.visible = false;
               this.btn_reinitColor1.visible = false;
               this.btn_reinitColor2.visible = false;
               this.btn_reinitColor3.visible = false;
               this.btn_reinitColor4.visible = false;
               this.cp_colorPk.disabled = true;
               this.btn_reinitColor.disabled = true;
               this.btn_generateColor.disabled = true;
               this.lbl_name.disabled = true;
               this.tx_name.disabled = true;
               this.btn_generateName.disabled = true;
               this.btn_more.disabled = true;
               this.btn_spell.disabled = true;
               break;
            case "recolor":
               this.gd_breed.disabled = true;
               for each(btn_gender2 in this._aGenders)
               {
                  btn_gender2.disabled = true;
               }
               this.gd_heads.disabled = true;
               this.lbl_name.disabled = true;
               this.tx_name.disabled = true;
               this.btn_generateName.disabled = true;
               this.tx_bgBreed.disabled = true;
               this.tx_bgColors.disabled = false;
               this.tx_bgHeads.disabled = true;
               this.btn_more.disabled = true;
               this.btn_spell.disabled = true;
               this.btn_showEquipment.visible = true;
               this.btn_showEquipment.selected = true;
               break;
         }
      }
      
      private function pickColor(index:uint) : void {
         var position:* = 0;
         this._selectedSlot = index;
         if(this.uiApi.keyIsDown(16))
         {
            if(this._aColors[index] != -1)
            {
               this.inp_hexaValue.text = this._aColors[index].toString(16);
            }
            else
            {
               this.inp_hexaValue.text = "";
            }
            this.ctr_hexaColor.visible = true;
            this.inp_hexaValue.focus();
            position = this.inp_hexaValue.text.length;
            this.inp_hexaValue.setSelection(position,position);
         }
         else if(this._aColors[index] != -1)
         {
            this.cp_colorPk.color = this._aColors[index];
         }
         
      }
      
      private function updateDirection(direction:int) : void {
         var e:EntityDisplayer = null;
         if((direction % 2 == 0) && (this.edChara.animation == "AnimAttaque0"))
         {
            this._direction = (direction + 1) % 8;
         }
         else
         {
            this._direction = direction;
         }
         this.edChara.direction = this._direction;
         for each(e in this._randomColorEntityDisplayers)
         {
            e.direction = this._direction;
         }
      }
      
      private function showInfos(spellTab:Boolean) : void {
         if(!this.ctr_info.visible)
         {
            if(spellTab)
            {
               this.gd_spells.visible = true;
               this.texta_breedInfo.visible = false;
               this.lbl_infoTitle.text = this.uiApi.getText("ui.common.breedSpell");
            }
            else
            {
               this.gd_spells.visible = false;
               this.texta_breedInfo.visible = true;
               this.lbl_infoTitle.text = this.uiApi.getText("ui.common.history");
            }
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.ctr_info.visible = true;
         }
         else if(spellTab == this.gd_spells.visible)
         {
            this.texta_breedInfo.visible = true;
            this.gd_spells.visible = true;
            this.ctr_info.visible = false;
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
         }
         else
         {
            if(spellTab)
            {
               this.gd_spells.visible = true;
               this.texta_breedInfo.visible = false;
               this.lbl_infoTitle.text = this.uiApi.getText("ui.common.breedSpell");
            }
            else
            {
               this.gd_spells.visible = false;
               this.texta_breedInfo.visible = true;
               this.lbl_infoTitle.text = this.uiApi.getText("ui.common.history");
            }
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.ctr_info.visible = true;
         }
         
      }
      
      private function updateRandomColorLook() : void {
         var i:* = 0;
         var j:* = 0;
         var colorArray:Array = null;
         i = 0;
         while(i <= COLOR_GENERATION_METHODE_NUMBER)
         {
            if((this._randomColorEntityDisplayers[i]) && (this.edChara.look))
            {
               this._randomColorEntityDisplayers[i].look.updateFrom(this.edChara.look);
               colorArray = this._randomLookColors[this._randomColorPage][i];
               j = 0;
               while(j < colorArray.length)
               {
                  this._randomColorEntityDisplayers[i].setColor(j + 1,colorArray[j]);
                  j++;
               }
            }
            this._randomColorEntityDisplayers[i].updateMask();
            i++;
         }
      }
      
      public function lockCreation() : void {
         this.btn_create.disabled = true;
      }
      
      public function onRelease(target:Object) : void {
         var color:uint = 0;
         switch(target)
         {
            case this.edChara:
               break;
            case this.btn_generateName:
               if(!this._bRequestCreation)
               {
                  this.sysApi.sendAction(new CharacterNameSuggestionRequest());
               }
               break;
            case this.btn_generateColor:
               if(this._randomLookColors.length < 100)
               {
                  this.generateColors();
               }
               else
               {
                  this.changeRandomPage(0);
               }
               if(this._aColors[this._selectedSlot] != -1)
               {
                  this.cp_colorPk.color = this._aColors[this._selectedSlot];
               }
               break;
            case this.btn_reinitColor:
               this.resetColor();
               if(this._aColors[this._selectedSlot] != -1)
               {
                  this.cp_colorPk.color = this._aColors[this._selectedSlot];
               }
               break;
            case this.btn_leftArrow:
               this.wheelChara(1);
               break;
            case this.btn_rightArrow:
               this.wheelChara(-1);
               break;
            case this.btn_sex0:
               if(this._gender != 0)
               {
                  this._direction = 3;
                  this.updateGender(0,true);
               }
               break;
            case this.btn_sex1:
               if(this._gender != 1)
               {
                  this._direction = 3;
                  this.updateGender(1,true);
               }
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
               color = int(Number("0x" + this.inp_hexaValue.text));
               this.onColorChange(new Object(),color);
               this.cp_colorPk.color = color;
               break;
            case this.btn_more:
               this.showInfos(false);
               break;
            case this.btn_spell:
               this.showInfos(true);
               break;
            case this.btn_infoClose:
               this.texta_breedInfo.visible = true;
               this.gd_spells.visible = true;
               this.ctr_info.visible = false;
               this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
               break;
            case this.btn_undo:
               this.sysApi.sendAction(new CharacterDeselection());
               Connection.getInstance().openPreviousUi();
               break;
            case this.btn_create:
               if(!this._bRequestCreation)
               {
                  this._bRequestCreation = true;
                  this.createChara();
               }
               break;
            case this.btn_randomLeft:
               if((this._randomColorPage == 0) && (this._randomLookColors.length < 100))
               {
                  this.generateColors();
               }
               else
               {
                  this.changeRandomPage(this._randomColorPage - 1);
               }
               break;
            case this.btn_randomRight:
               if(this._randomLookColors.length - 1 > this._randomColorPage)
               {
                  this.changeRandomPage(this._randomColorPage + 1);
               }
               else
               {
                  this.generateColors();
               }
               break;
            case this.btn_showEquipment:
               if(!this.btn_showEquipment.selected)
               {
                  this.edChara.look = this._noStuffLook.toString();
               }
               else
               {
                  this.edChara.look = this._look;
               }
               this.onRollOver(target);
               break;
         }
      }
      
      public function onDoubleClick(target:Object) : void {
         switch(target)
         {
            case this.btn_leftArrow:
               this.wheelChara(1);
               break;
            case this.btn_rightArrow:
               this.wheelChara(-1);
               break;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var numBreed:* = 0;
         var textkey:String = null;
         var breed:Object = null;
         var i:* = 0;
         if(selectMethod != GridItemSelectMethodEnum.AUTO)
         {
            if(target == this.gd_breed)
            {
               this._breedIndex = this.gd_breed.selectedIndex;
               this._direction = 3;
               breed = this._aBreeds[this._breedIndex];
               if(!breed)
               {
                  return;
               }
               numBreed = breed.id;
               if((!(this._mode == "create")) || (Connection.BREEDS_AVAILABLE > 0) && ((Math.pow(2,numBreed - 1) & Connection.BREEDS_AVAILABLE) > 0))
               {
                  if((numBreed) && (!(numBreed == this._breed)))
                  {
                     this._breed = numBreed;
                     this.displayBreed();
                  }
               }
               else
               {
                  textkey = "ui.charcrea.breedNotAvailable";
                  if((numBreed == 12) || (numBreed == 13) || (numBreed == 14))
                  {
                     textkey = textkey + ("." + numBreed);
                  }
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText(textkey),[this.uiApi.getText("ui.common.ok")],null,null,null,null,false,true);
                  this.gd_breed.selectedIndex = 0;
               }
            }
            else if(target == this.gd_heads)
            {
               this._head = this.gd_heads.selectedItem.id;
               this.displayCharacter();
            }
            else if(target == this.gd_randomColorPrevisualisation)
            {
               this._aColors = this._randomLookColors[this._randomColorPage][this.gd_randomColorPrevisualisation.selectedIndex].concat();
               i = 0;
               while(i < this._aTx_color.length)
               {
                  this.changeColor(this._aTx_color[i],this._aColors[i]);
                  i++;
               }
               this.colorizeCharacter();
            }
            
            
         }
      }
      
      public function onEntityReady(target:Object) : void {
         var i:* = 0;
         if(!this._randomInitialized)
         {
            i = 0;
            while(i < this._randomColorEntityDisplayers.length)
            {
               this._randomColorEntityDisplayers[i].look = this.edChara.look;
               this._randomColorEntityDisplayers[i].scaleX = 1.8;
               this._randomColorEntityDisplayers[i].scaleY = 1.8;
               this._randomColorEntityDisplayers[i].look = this.edChara.look.toString();
               this._randomColorEntityDisplayers[i].direction = this._direction;
               i++;
            }
            this._randomInitialized = true;
         }
         else
         {
            if(this._randomColorPage >= 0)
            {
               this.updateRandomColorLook();
            }
            if(this._mode == "recolor")
            {
               this.colorizeCharacter();
            }
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         if(item.data)
         {
            this.uiApi.showTooltip(item.data,item.container,false,"standard",LocationEnum.POINT_BOTTOMRIGHT);
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var text:String = null;
         switch(target)
         {
            case this.tx_nameRules:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.charcrea.nameRules")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
               break;
            case this.btn_sex0:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tooltip.male")),target,false,"standard",7,2,3,null,null,null,"TextInfo");
               break;
            case this.btn_sex1:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tooltip.female")),target,false,"standard",7,2,3,null,null,null,"TextInfo");
               break;
            case this.btn_color0:
               this._overSlot = 0;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_color1:
               this._overSlot = 1;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_color2:
               this._overSlot = 2;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_color3:
               this._overSlot = 3;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_color4:
               this._overSlot = 4;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_showEquipment:
               if(this.btn_showEquipment.selected)
               {
                  tooltipText = this.uiApi.getText("ui.charcrea.hideStuff");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.charcrea.showStuff");
               }
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,2,3,null,null,null,"TextInfo");
               break;
            default:
               if(target.name.indexOf("btn_head") != -1)
               {
                  if(this._dataHeadList[target.name])
                  {
                     text = this.uiApi.getText("ui.charcrea.face") + " " + this._dataHeadList[target.name].label;
                     this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,2,3,null,null,null,"TextInfo");
                  }
               }
         }
      }
      
      public function onColorChange(target:Object, fixedColor:int = -1) : void {
         var color:uint = 0;
         if((!this.ctr_hexaColor.visible) || (fixedColor == -1))
         {
            color = this.cp_colorPk.color;
         }
         else
         {
            color = fixedColor;
         }
         this.ctr_hexaColor.visible = false;
         var selectedItem:Object = this.uiApi.getRadioGroupSelectedItem("colorGroup",this.uiApi.me());
         switch(selectedItem.name)
         {
            case this.btn_color0.name:
               this._aColors[0] = color;
               this.changeColor(this.tx_color0,color);
               break;
            case this.btn_color1.name:
               this._aColors[1] = color;
               this.changeColor(this.tx_color1,color);
               break;
            case this.btn_color2.name:
               this._aColors[2] = color;
               this.changeColor(this.tx_color2,color);
               break;
            case this.btn_color3.name:
               this._aColors[3] = color;
               this.changeColor(this.tx_color3,color);
               break;
            case this.btn_color4.name:
               this._aColors[4] = color;
               this.changeColor(this.tx_color4,color);
               break;
         }
         this.colorizeCharacter();
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
         this.sysApi.removeEventListener(this.onEnterFrame);
         if((target == this.btn_color0) || (target == this.btn_color1) || (target == this.btn_color2) || (target == this.btn_color3) || (target == this.btn_color4))
         {
            if(this._aColors[this._overSlot] != -1)
            {
               this.edChara.setColor(this._overSlot + 1,this._aColors[this._overSlot]);
            }
            else
            {
               this.edChara.setColor(this._overSlot + 1,this._aColorsBase[this._overSlot]);
            }
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         var color:uint = 0;
         switch(s)
         {
            case "validUi":
               if(this.ctr_hexaColor.visible)
               {
                  color = int(Number("0x" + this.inp_hexaValue.text));
                  this.onColorChange(new Object(),color);
                  this.cp_colorPk.color = color;
               }
               else if(!this._bRequestCreation)
               {
                  this._bRequestCreation = true;
                  this.createChara();
               }
               
               return true;
            case "closeUi":
               if(this.ctr_hexaColor.visible)
               {
                  this.ctr_hexaColor.visible = false;
                  return true;
               }
            default:
               return false;
         }
      }
      
      public function onCharacterCreationResult(result:int) : void {
         if(result > 0)
         {
            switch(result)
            {
               case CharacterCreationResultEnum.ERR_INVALID_NAME:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.invalidName"),[this.uiApi.getText("ui.common.ok")]);
                  break;
               case CharacterCreationResultEnum.ERR_NAME_ALREADY_EXISTS:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.nameAlreadyExist"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Ce nom existe deja.");
                  break;
               case CharacterCreationResultEnum.ERR_NOT_ALLOWED:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.notSubscriber"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Seuls les abonnés peuvent jouer cette classe de personnage.");
                  break;
               case CharacterCreationResultEnum.ERR_TOO_MANY_CHARACTERS:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.tooManyCharacters"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Vous avez deja trop de personnages");
                  break;
               case CharacterCreationResultEnum.ERR_NO_REASON:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.noReason"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Echec sans raison");
                  break;
               case CharacterCreationResultEnum.ERR_RESTRICED_ZONE:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.charSel.deletionErrorUnsecureMode"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Vous ne pouvez pas créer de personnage en mode Unsecure");
                  break;
            }
         }
         else
         {
            this.soundApi.playLookSound(this._currentLook,LookTypeSoundEnum.CHARACTER_SELECTION);
            Connection.TUTORIAL_SELECTION = true;
         }
         this._bRequestCreation = false;
         this.btn_create.disabled = false;
         this.btn_generateName.disabled = false;
      }
      
      public function onCharacterImpossibleSelection(pCharacterId:uint) : void {
         this._bRequestCreation = false;
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.impossible_action"),this.uiApi.getText("ui.common.cantSelectThisCharacter"),[this.uiApi.getText("ui.common.ok")]);
      }
      
      public function onCharacterNameSuggestioned(characterName:String) : void {
         this.lbl_name.text = characterName;
      }
      
      public function onInput(te:Object) : void {
         if((!(this._lang == "ru")) && (!(this._lang == "ja")))
         {
            if(this.lbl_name.text.length == 1)
            {
               this.lbl_name.text = this.lbl_name.text.toLocaleUpperCase();
            }
         }
      }
      
      public function onEnterFrame() : void {
         this._frameCount++;
         if(this._frameCount > 4)
         {
            this.edChara.setColor(this._overSlot + 1,16759552);
            this._frameCount = 0;
         }
         else if(this._frameCount > 2)
         {
            this.edChara.setColor(this._overSlot + 1,16776960);
         }
         
      }
      
      private function getColorByXYSlideX(x:Number, y:Number, slideY:Number) : uint {
         var r1:* = NaN;
         var g1:* = NaN;
         var b1:* = NaN;
         var r2:* = NaN;
         var g2:* = NaN;
         var b2:* = NaN;
         var nGradientColor:uint = this.getGradientColor(x,y);
         var colorPoint:Number = 255 - slideY / 100 * 510;
         var color:uint = 0;
         r1 = (nGradientColor & 16711680) >> 16;
         g1 = (nGradientColor & 65280) >> 8;
         b1 = nGradientColor & 255;
         if(colorPoint >= 0)
         {
            r2 = colorPoint * (255 - r1) / 255 + r1;
            g2 = colorPoint * (255 - g1) / 255 + g1;
            b2 = colorPoint * (255 - b1) / 255 + b1;
         }
         else
         {
            colorPoint = colorPoint * -1;
            r2 = Math.round(r1 - r1 * colorPoint / 255);
            g2 = Math.round(g1 - g1 * colorPoint / 255);
            b2 = Math.round(b1 - b1 * colorPoint / 255);
         }
         color = Math.round((r2 << 16) + (g2 << 8) + b2);
         return color;
      }
      
      private function getGradientColor(x:Number, y:Number) : uint {
         var colorPoint1:* = NaN;
         var colorPoint2:* = NaN;
         var r1:* = NaN;
         var g1:* = NaN;
         var b1:* = NaN;
         var r2:* = NaN;
         var g2:* = NaN;
         var b2:* = NaN;
         var c1:* = NaN;
         var c2:* = NaN;
         var r:* = NaN;
         var g:* = NaN;
         var b:* = NaN;
         var gradientColor:uint = 0;
         var aColorsHue:Array = new Array(16711680,16776960,65280,65535,255,16711935,16711680);
         var aRatiosHue:Array = new Array(0,1 * 255 / 6,2 * 255 / 6,3 * 255 / 6,4 * 255 / 6,5 * 255 / 6,255);
         var gradientWidth:Number = 1000;
         var gradientHeight:Number = 1000;
         if(x >= gradientWidth)
         {
            x = gradientWidth - 1;
         }
         colorPoint1 = x / gradientWidth;
         var i:Number = Math.floor(colorPoint1 * (aRatiosHue.length - 1));
         colorPoint1 = colorPoint1 * 255;
         colorPoint2 = 255 - (aRatiosHue[i + 1] - colorPoint1) / (aRatiosHue[i + 1] - aRatiosHue[i]) * 255;
         c1 = aColorsHue[i];
         c2 = aColorsHue[i + 1];
         r1 = c1 & 16711680;
         g1 = c1 & 65280;
         b1 = c1 & 255;
         r2 = c2 & 16711680;
         g2 = c2 & 65280;
         b2 = c2 & 255;
         if(r1 != r2)
         {
            r = Math.round(r1 > r2?255 - colorPoint2:colorPoint2);
         }
         else
         {
            r = r1 >> 16;
         }
         if(g1 != g2)
         {
            g = Math.round(g1 > g2?255 - colorPoint2:colorPoint2);
         }
         else
         {
            g = g1 >> 8;
         }
         if(b1 != b2)
         {
            b = Math.round(b1 > b2?255 - colorPoint2:colorPoint2);
         }
         else
         {
            b = b1;
         }
         colorPoint1 = y / gradientHeight * 255;
         r = r + (127 - r) * colorPoint1 / 255;
         g = g + (127 - g) * colorPoint1 / 255;
         b = b + (127 - b) * colorPoint1 / 255;
         gradientColor = Math.round((r << 16) + (g << 8) + b);
         return gradientColor;
      }
   }
}
