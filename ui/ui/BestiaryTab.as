package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.PlayedCharacterApi;
   import d2api.ContextMenuApi;
   import d2api.AveragePricesApi;
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import d2components.Grid;
   import d2components.Input;
   import d2components.Texture;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2enums.ComponentHookList;
   import flash.events.TimerEvent;
   import d2hooks.*;
   import d2actions.*;
   import d2data.SubArea;
   import d2data.Monster;
   import d2data.MonsterGrade;
   import d2data.MonsterDrop;
   import d2data.ItemWrapper;
   import flash.utils.getTimer;
   import d2data.Item;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   import d2enums.LocationEnum;
   import d2data.MonsterMiniBoss;
   import flash.ui.Keyboard;
   import flash.utils.clearTimeout;
   import d2data.MonsterRace;
   
   public class BestiaryTab extends Object
   {
      
      public function BestiaryTab() {
         this._categoriesRace = new Array();
         this._categoriesArea = new Array();
         this._monstersListToDisplay = new Array();
         this._ctrBtnMonsterLocation = new Dictionary(true);
         this._ctrBtnMonster = new Dictionary(true);
         this._ctrSlotDrop = new Dictionary(true);
         this._ctrTxLink = new Dictionary(true);
         this._searchTextByCriteriaList = new Dictionary(true);
         this._searchResultByCriteriaList = new Dictionary(true);
         super();
      }
      
      private static var CTR_CAT_TYPE_CAT:String = "ctr_cat";
      
      private static var CTR_CAT_TYPE_SUBCAT:String = "ctr_subCat";
      
      private static var CTR_MONSTER_BASE:String = "ctr_monster";
      
      private static var CTR_MONSTER_AREAS:String = "ctr_subareas";
      
      private static var CTR_MONSTER_DETAILS:String = "ctr_details";
      
      private static var CTR_MONSTER_DROPS:String = "ctr_drops";
      
      private static var CAT_TYPE_AREA:int = 0;
      
      private static var CAT_TYPE_RACE:int = 1;
      
      private static var NB_DROP_PER_LINE:int = 12;
      
      private static var AREA_LINE_HEIGHT:int;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var menuApi:ContextMenuApi;
      
      public var averagePricesApi:AveragePricesApi;
      
      public var modContextMenu:Object;
      
      public var modCartography:Object;
      
      private var _currentCategoryType:int;
      
      private var _openCatIndex:int;
      
      private var _currentSelectedCatId:int;
      
      private var _selectedMonsterId:int;
      
      private var _selectedAndOpenedMonsterId:int;
      
      private var _uriRareDrop:String;
      
      private var _uriOkDrop:String;
      
      private var _uriSpecialSlot:String;
      
      private var _uriEmptySlot:String;
      
      private var _uriStatPicto:String;
      
      private var _uriMonsterSprite:String;
      
      private var _lastRaceSelected:Object;
      
      private var _lastAreaSelected:Object;
      
      private var _categoriesRace:Array;
      
      private var _categoriesArea:Array;
      
      private var _monstersListToDisplay:Array;
      
      private var _lockSearchTimer:Timer;
      
      private var _previousSearchCriteria:String;
      
      private var _searchCriteria:String;
      
      private var _forceOpenMonster:Boolean;
      
      private var _currentScrollValue:int;
      
      private var _mapPopup:String;
      
      private var _ctrBtnMonsterLocation:Dictionary;
      
      private var _ctrBtnMonster:Dictionary;
      
      private var _ctrSlotDrop:Dictionary;
      
      private var _ctrTxLink:Dictionary;
      
      private var _progressPopupName:String;
      
      private var _searchSettimoutId:uint;
      
      private var _searchTextByCriteriaList:Dictionary;
      
      private var _searchResultByCriteriaList:Dictionary;
      
      private var _searchOnName:Boolean;
      
      private var _searchOnDrop:Boolean;
      
      public var gd_categories:Grid;
      
      public var gd_monsters:Grid;
      
      public var inp_search:Input;
      
      public var tx_inputBg:Texture;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var btn_searchFilter:ButtonContainer;
      
      public var btn_races:ButtonContainer;
      
      public var btn_subareas:ButtonContainer;
      
      public var btn_displayCriteriaDrop:ButtonContainer;
      
      public var lbl_noMonster:Label;
      
      public function main(oParam:Object = null) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function unload() : void {
         this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         this._lockSearchTimer.stop();
         this._lockSearchTimer = null;
         this.uiApi.unloadUi(this._mapPopup);
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void {
         switch(this.getCatLineType(data,line))
         {
            case CTR_CAT_TYPE_CAT:
            case CTR_CAT_TYPE_SUBCAT:
               componentsRef.lbl_catName.text = data.name;
               componentsRef.btn_cat.selected = selected;
               break;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String {
         if(!data)
         {
            return "";
         }
         switch(line)
         {
            case 0:
               if((data) && (data.parentId == 0))
               {
                  return CTR_CAT_TYPE_CAT;
               }
               return CTR_CAT_TYPE_SUBCAT;
            default:
               return CTR_CAT_TYPE_SUBCAT;
         }
      }
      
      public function getCatDataLength(data:*, selected:Boolean) : * {
         if(selected)
         {
            trace(data.title + " : " + (2 + (selected?data.subcats.length:0)));
         }
         return 2 + (selected?data.subcats.length:0);
      }
      
      public function updateMonsterSubarea(data:*, compRef:*, selected:Boolean) : void {
         if(data)
         {
            if(!this._ctrBtnMonsterLocation[compRef.btn_loc.name])
            {
               this.uiApi.addComponentHook(compRef.btn_loc,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(compRef.btn_loc,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(compRef.btn_loc,ComponentHookList.ON_RELEASE);
            }
            this._ctrBtnMonsterLocation[compRef.btn_loc.name] = data;
            compRef.lbl_subarea.text = this.dataApi.getArea(data.areaId).name + " - " + data.name;
            compRef.btn_loc.visible = true;
         }
         else
         {
            compRef.lbl_subarea.text = "";
            compRef.btn_loc.visible = false;
         }
      }
      
      public function updateMonsterStatLine(data:*, compRef:*, selected:Boolean) : void {
         if(data)
         {
            compRef.lbl_text.text = data;
         }
         else
         {
            compRef.lbl_text.text = "";
         }
      }
      
      public function updateMonsterResistLine(data:*, compRef:*, selected:Boolean) : void {
         if(data)
         {
            compRef.lbl_text.text = !(data.text == "0")?data.text:"";
            compRef.tx_picto.uri = this.uiApi.createUri(this._uriStatPicto + data.gfxId);
         }
         else
         {
            compRef.lbl_text.text = "";
            compRef.tx_picto.uri = null;
         }
      }
      
      public function updateMonster(data:*, compRef:*, selected:Boolean, line:uint) : void {
         var monster:Monster = null;
         var gradeMin:MonsterGrade = null;
         var gradeMax:MonsterGrade = null;
         var tempSubareas:Array = null;
         var lastGradeId:* = 0;
         var stats:Array = null;
         var minN:* = 0;
         var minE:* = 0;
         var minF:* = 0;
         var minW:* = 0;
         var minA:* = 0;
         var maxN:* = 0;
         var maxE:* = 0;
         var maxF:* = 0;
         var maxW:* = 0;
         var maxA:* = 0;
         var resists:Array = null;
         var dropsSlotContent:Array = null;
         var pos:* = 0;
         var rareTexture:Object = null;
         var okTexture:Object = null;
         var i:* = 0;
         var subarea:SubArea = null;
         var areaName:String = null;
         var subareaName:String = null;
         var subareaId:* = 0;
         var grade:Object = null;
         var drop:MonsterDrop = null;
         var item:ItemWrapper = null;
         var slot:Object = null;
         switch(this.getMonsterLineType(data,line))
         {
            case CTR_MONSTER_BASE:
               this.uiApi.addComponentHook(compRef.tx_boss,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(compRef.tx_boss,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(compRef.tx_archMonster,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(compRef.tx_archMonster,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(compRef.tx_questMonster,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(compRef.tx_questMonster,ComponentHookList.ON_ROLL_OUT);
               if(!this._ctrTxLink[compRef.btn_linkToMonster.name])
               {
                  this.uiApi.addComponentHook(compRef.btn_linkToMonster,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.btn_linkToMonster,ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.addComponentHook(compRef.btn_linkToMonster,ComponentHookList.ON_RELEASE);
               }
               this._ctrTxLink[compRef.btn_linkToMonster.name] = data;
               if(!this._ctrTxLink[compRef.btn_linkToArch.name])
               {
                  this.uiApi.addComponentHook(compRef.btn_linkToArch,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.btn_linkToArch,ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.addComponentHook(compRef.btn_linkToArch,ComponentHookList.ON_RELEASE);
               }
               this._ctrTxLink[compRef.btn_linkToArch.name] = data;
               monster = this.dataApi.getMonsterFromId(data);
               if(!monster)
               {
                  this.sysApi.log(16,"On veut le monstre " + data + " mais il ne semble pas exister !");
                  break;
               }
               if(!this._ctrBtnMonster[compRef.btn_monster.name])
               {
                  this.uiApi.addComponentHook(compRef.btn_monster,ComponentHookList.ON_RELEASE);
               }
               this._ctrBtnMonster[compRef.btn_monster.name] = monster;
               compRef.btn_monster.handCursor = true;
               compRef.lbl_name.text = monster.name;
               if(this.sysApi.getPlayerManager().hasRights)
               {
                  compRef.lbl_name.text = compRef.lbl_name.text + (" (" + monster.id + ")");
               }
               if(monster.isBoss)
               {
                  compRef.tx_boss.visible = true;
               }
               else
               {
                  compRef.tx_boss.visible = false;
               }
               if(monster.isMiniBoss)
               {
                  compRef.tx_archMonster.visible = true;
               }
               else
               {
                  compRef.tx_archMonster.visible = false;
               }
               if(monster.isQuestMonster)
               {
                  compRef.tx_questMonster.visible = true;
               }
               else
               {
                  compRef.tx_questMonster.visible = false;
               }
               compRef.btn_linkToMonster.visible = false;
               compRef.btn_linkToArch.visible = false;
               if(monster.isMiniBoss)
               {
                  compRef.btn_linkToMonster.visible = true;
               }
               else if(monster.correspondingMiniBossId > 0)
               {
                  compRef.btn_linkToArch.visible = true;
               }
               
               if(monster.favoriteSubareaId > 0)
               {
                  subarea = this.dataApi.getSubArea(monster.favoriteSubareaId);
                  areaName = this.dataApi.getArea(subarea.areaId).name;
                  subareaName = subarea.name;
                  if(subareaName.indexOf(areaName) != -1)
                  {
                     compRef.lbl_bestSubarea.text = subareaName;
                  }
                  else
                  {
                     compRef.lbl_bestSubarea.text = subareaName + " (" + areaName + ")";
                  }
                  if(!this._ctrBtnMonsterLocation[compRef.btn_loc.name])
                  {
                     this.uiApi.addComponentHook(compRef.btn_loc,ComponentHookList.ON_ROLL_OVER);
                     this.uiApi.addComponentHook(compRef.btn_loc,ComponentHookList.ON_ROLL_OUT);
                     this.uiApi.addComponentHook(compRef.btn_loc,ComponentHookList.ON_RELEASE);
                  }
                  this._ctrBtnMonsterLocation[compRef.btn_loc.name] = monster;
                  compRef.btn_loc.visible = true;
                  if((!subarea.hasCustomWorldMap) && (!subarea.area.superArea.hasWorldMap))
                  {
                     compRef.btn_loc.softDisabled = true;
                  }
                  else
                  {
                     compRef.btn_loc.softDisabled = false;
                  }
               }
               else
               {
                  compRef.lbl_bestSubarea.text = this.uiApi.getText("ui.monster.noFavoriteZone");
                  compRef.btn_loc.visible = false;
               }
               gradeMin = monster.grades[0];
               gradeMax = monster.grades[monster.grades.length - 1];
               compRef.lbl_level.text = this.uiApi.getText("ui.common.short.level") + " " + this.getStringFromValues(gradeMin.level,gradeMax.level);
               compRef.tx_sprite.uri = this.uiApi.createUri(this._uriMonsterSprite + data + ".png");
               break;
            case CTR_MONSTER_AREAS:
               tempSubareas = new Array();
               for each(subareaId in data.subareasList)
               {
                  tempSubareas.push(this.dataApi.getSubArea(subareaId));
               }
               if(tempSubareas.length <= 2)
               {
                  compRef.gd_subareas.height = AREA_LINE_HEIGHT * 2;
               }
               else
               {
                  compRef.gd_subareas.height = AREA_LINE_HEIGHT * 5;
               }
               compRef.gd_subareas.dataProvider = tempSubareas;
               break;
            case CTR_MONSTER_DETAILS:
               this._selectedAndOpenedMonsterId = this._selectedMonsterId;
               lastGradeId = data.grades.length - 1;
               stats = new Array();
               stats.push(this.uiApi.getText("ui.short.lifePoints") + this.uiApi.getText("ui.common.colon") + this.getStringFromValues(data.grades[0].lifePoints,data.grades[lastGradeId].lifePoints));
               stats.push(this.uiApi.getText("ui.short.actionPoints") + this.uiApi.getText("ui.common.colon") + this.getStringFromValues(data.grades[0].actionPoints,data.grades[lastGradeId].actionPoints));
               stats.push(this.uiApi.getText("ui.short.movementPoints") + this.uiApi.getText("ui.common.colon") + this.getStringFromValues(data.grades[0].movementPoints,data.grades[lastGradeId].movementPoints));
               compRef.gd_stats.dataProvider = stats;
               minN = -1;
               minE = -1;
               minF = -1;
               minW = -1;
               minA = -1;
               maxN = -1;
               maxE = -1;
               maxF = -1;
               maxW = -1;
               maxA = -1;
               for each(grade in data.grades)
               {
                  if((minN == -1) || (grade.neutralResistance < minN))
                  {
                     minN = grade.neutralResistance;
                  }
                  if((maxN == -1) || (grade.neutralResistance > maxN))
                  {
                     maxN = grade.neutralResistance;
                  }
                  if((minE == -1) || (grade.earthResistance < minE))
                  {
                     minE = grade.earthResistance;
                  }
                  if((maxE == -1) || (grade.earthResistance > maxE))
                  {
                     maxE = grade.earthResistance;
                  }
                  if((minF == -1) || (grade.fireResistance < minF))
                  {
                     minF = grade.fireResistance;
                  }
                  if((maxF == -1) || (grade.fireResistance > maxF))
                  {
                     maxF = grade.fireResistance;
                  }
                  if((minW == -1) || (grade.waterResistance < minW))
                  {
                     minW = grade.waterResistance;
                  }
                  if((maxW == -1) || (grade.waterResistance > maxW))
                  {
                     maxW = grade.waterResistance;
                  }
                  if((minA == -1) || (grade.airResistance < minA))
                  {
                     minA = grade.airResistance;
                  }
                  if((maxA == -1) || (grade.airResistance > maxA))
                  {
                     maxA = grade.airResistance;
                  }
               }
               resists = new Array();
               resists.push(
                  {
                     "text":this.getStringFromValues(minN,maxN),
                     "gfxId":"neutral"
                  });
               resists.push(
                  {
                     "text":this.getStringFromValues(minE,maxE),
                     "gfxId":"strength"
                  });
               resists.push(
                  {
                     "text":this.getStringFromValues(minF,maxF),
                     "gfxId":"intelligence"
                  });
               resists.push(
                  {
                     "text":this.getStringFromValues(minW,maxW),
                     "gfxId":"chance"
                  });
               resists.push(
                  {
                     "text":this.getStringFromValues(minA,maxA),
                     "gfxId":"agility"
                  });
               compRef.gd_resists.dataProvider = resists;
               if(data.hasDrops)
               {
                  compRef.lbl_drops.text = this.uiApi.getText("ui.common.loot");
               }
               else
               {
                  compRef.lbl_drops.text = "";
               }
               break;
            case CTR_MONSTER_DROPS:
               dropsSlotContent = new Array();
               pos = 0;
               for each(drop in data.dropsList)
               {
                  item = this.dataApi.getItemWrapper(drop.objectId,pos,0,1);
                  pos++;
                  dropsSlotContent.push(item);
               }
               rareTexture = this.uiApi.createUri(this._uriRareDrop);
               okTexture = this.uiApi.createUri(this._uriOkDrop);
               compRef.gd_drops.dataProvider = dropsSlotContent;
               i = 0;
               for each(slot in compRef.gd_drops.slots)
               {
                  if((data.dropsList[i]) && (data.dropsList[i].hasCriteria))
                  {
                     slot.forcedBackGroundIconUri = this.uiApi.createUri(this._uriSpecialSlot);
                  }
                  else if(data.dropsList[i])
                  {
                     slot.forcedBackGroundIconUri = this.uiApi.createUri(this._uriEmptySlot);
                  }
                  else
                  {
                     slot.forcedBackGroundIconUri = null;
                  }
                  
                  if((data.dropsList[i]) && (data.dropsList[i].percentDropForGrade1 < 2))
                  {
                     slot.customTexture = rareTexture;
                  }
                  else if((data.dropsList[i]) && (data.dropsList[i].percentDropForGrade1 < 10))
                  {
                     slot.customTexture = okTexture;
                  }
                  else
                  {
                     slot.customTexture = null;
                  }
                  
                  i++;
               }
               if(!this._ctrSlotDrop[compRef.gd_drops.name])
               {
                  this.uiApi.addComponentHook(compRef.gd_drops,ComponentHookList.ON_ITEM_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.gd_drops,ComponentHookList.ON_ITEM_ROLL_OUT);
                  this.uiApi.addComponentHook(compRef.gd_drops,ComponentHookList.ON_ITEM_RIGHT_CLICK);
               }
               this._ctrSlotDrop[compRef.gd_drops.name] = data;
               break;
         }
      }
      
      public function getMonsterLineType(data:*, line:uint) : String {
         if(!data)
         {
            return "";
         }
         switch(line)
         {
            case 0:
               if(data.hasOwnProperty("dropsList"))
               {
                  return CTR_MONSTER_DROPS;
               }
               if(data.hasOwnProperty("grades"))
               {
                  return CTR_MONSTER_DETAILS;
               }
               if(data.hasOwnProperty("subareasList"))
               {
                  return CTR_MONSTER_AREAS;
               }
               return CTR_MONSTER_BASE;
            default:
               return CTR_MONSTER_BASE;
         }
      }
      
      public function getMonsterDataLength(data:*, selected:Boolean) : * {
         return 1;
      }
      
      private function updateMonsterGrid(category:Object) : void {
         var tempMonstersSorted:Object = null;
         var id:uint = 0;
         var ts:uint = 0;
         var result:Object = null;
         var critSplit:Array = null;
         var nameResult:Object = null;
         var dropResult:Object = null;
         var mId:* = undefined;
         var currentCriteria:String = null;
         var wannabeCriteria:String = null;
         var crit:String = null;
         var index:int = 0;
         var indexToScroll:int = 0;
         var monsters:Array = new Array();
         this._selectedAndOpenedMonsterId = 0;
         var vectoruint:Vector.<uint> = new Vector.<uint>();
         var alternativeSearchResults:int = 0;
         if((!this._monstersListToDisplay) || (this._monstersListToDisplay.length == 0))
         {
            if(!this._searchCriteria)
            {
               if(category.parentId > 0)
               {
                  for each(id in category.monsters)
                  {
                     if(id)
                     {
                        vectoruint.push(id);
                     }
                  }
                  tempMonstersSorted = this.dataApi.querySort(Monster,vectoruint,["isBoss","isMiniBoss","name"],[false,true,true]);
                  for each(id in tempMonstersSorted)
                  {
                     monsters.push(id);
                     monsters.push(null);
                     if(id == this._selectedMonsterId)
                     {
                        indexToScroll = index;
                        monsters = monsters.concat(this.addDetails(id,category));
                     }
                     index++;
                     index++;
                  }
               }
            }
            else if(this._previousSearchCriteria != this._searchCriteria + "#" + this.btn_displayCriteriaDrop.selected + "#" + this._searchOnName + "" + this._searchOnDrop)
            {
               ts = getTimer();
               critSplit = this._previousSearchCriteria?this._previousSearchCriteria.split("#"):[];
               if((!(this._searchCriteria == critSplit[0])) || (!(this.btn_displayCriteriaDrop.selected.toString() == critSplit[1])))
               {
                  nameResult = this.dataApi.queryString(Monster,"name",this._searchCriteria);
                  if(this.btn_displayCriteriaDrop.selected)
                  {
                     dropResult = this.dataApi.queryEquals(Monster,"drops.objectId",this.dataApi.queryString(Item,"name",this._searchCriteria));
                  }
                  else
                  {
                     dropResult = this.dataApi.queryIntersection(this.dataApi.queryEquals(Monster,"drops.objectId",this.dataApi.queryString(Item,"name",this._searchCriteria)),this.dataApi.queryEquals(Monster,"drops.hasCriteria",false));
                  }
                  this._searchResultByCriteriaList["_searchOnName"] = nameResult;
                  this._searchResultByCriteriaList["_searchOnDrop"] = dropResult;
                  if((nameResult) || (dropResult))
                  {
                     this.sysApi.log(2,"Result : " + ((nameResult?nameResult.length:0) + (dropResult?dropResult.length:0)) + " in " + (getTimer() - ts) + " ms");
                  }
               }
               if((this._searchOnName) && (this._searchOnDrop))
               {
                  result = this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"],this._searchResultByCriteriaList["_searchOnDrop"]);
               }
               else if(this._searchOnName)
               {
                  result = this._searchResultByCriteriaList["_searchOnName"];
               }
               else if(this._searchOnDrop)
               {
                  result = this._searchResultByCriteriaList["_searchOnDrop"];
               }
               else
               {
                  this.gd_monsters.dataProvider = new Array();
                  this.lbl_noMonster.visible = true;
                  this.lbl_noMonster.text = this.uiApi.getText("ui.search.needCriterion");
                  this._previousSearchCriteria = this._searchCriteria + "#" + this.btn_displayCriteriaDrop.selected + "#" + this._searchOnName + "" + this._searchOnDrop;
                  return;
               }
               
               
               for each(id in result)
               {
                  vectoruint.push(id);
               }
               tempMonstersSorted = this.dataApi.querySort(Monster,vectoruint,["isBoss","isMiniBoss","name"],[false,true,true]);
               for each(id in tempMonstersSorted)
               {
                  monsters.push(id);
                  monsters.push(null);
                  if(id == this._selectedMonsterId)
                  {
                     indexToScroll = index;
                     monsters = monsters.concat(this.addDetails(id,category));
                  }
                  index++;
                  index++;
               }
            }
            else
            {
               for each(mId in this.gd_monsters.dataProvider)
               {
                  if((mId) && (mId is int))
                  {
                     monsters.push(mId);
                     monsters.push(null);
                     if(mId == this._selectedMonsterId)
                     {
                        indexToScroll = index;
                        monsters = monsters.concat(this.addDetails(int(mId),category));
                     }
                     index++;
                     index++;
                  }
               }
            }
            
         }
         else
         {
            for each(id in this._monstersListToDisplay)
            {
               vectoruint.push(id);
            }
            tempMonstersSorted = this.dataApi.querySort(Monster,vectoruint,["isBoss","isMiniBoss","name"],[false,true,true]);
            for each(id in tempMonstersSorted)
            {
               monsters.push(id);
               monsters.push(null);
               if(id == this._selectedMonsterId)
               {
                  indexToScroll = index;
                  monsters = monsters.concat(this.addDetails(id,category));
               }
               index++;
               index++;
            }
         }
         if(monsters.length)
         {
            this.gd_monsters.dataProvider = monsters;
            this.lbl_noMonster.visible = false;
         }
         else
         {
            this.gd_monsters.dataProvider = new Array();
            this.lbl_noMonster.visible = true;
            this.lbl_noMonster.text = this.uiApi.getText("ui.search.noResult");
            if(this._searchCriteria)
            {
               currentCriteria = "";
               wannabeCriteria = "";
               for(crit in this._searchTextByCriteriaList)
               {
                  if(this[crit])
                  {
                     currentCriteria = currentCriteria + (this._searchTextByCriteriaList[crit] + ", ");
                  }
                  else if(this._searchResultByCriteriaList[crit].length > 0)
                  {
                     wannabeCriteria = wannabeCriteria + (this._searchTextByCriteriaList[crit] + ", ");
                  }
                  
               }
               if(currentCriteria.length > 0)
               {
                  currentCriteria = currentCriteria.slice(0,-2);
               }
               if(wannabeCriteria.length > 0)
               {
                  wannabeCriteria = wannabeCriteria.slice(0,-2);
               }
               if(wannabeCriteria.length == 0)
               {
                  this.lbl_noMonster.text = this.uiApi.getText("ui.search.noResultFor",this._searchCriteria);
               }
               else
               {
                  this.lbl_noMonster.text = this.uiApi.getText("ui.search.noResultsBut",currentCriteria,wannabeCriteria);
               }
            }
         }
         if(this._forceOpenMonster)
         {
            this._forceOpenMonster = false;
            this.gd_monsters.moveTo(indexToScroll,true);
         }
         if(this._currentScrollValue != 0)
         {
            this.gd_monsters.verticalScrollValue = this._currentScrollValue;
         }
         this._previousSearchCriteria = this._searchCriteria + "#" + this.btn_displayCriteriaDrop.selected + "#" + this._searchOnName + "" + this._searchOnDrop;
      }
      
      private function addDetails(monsterId:int, category:Object) : Array {
         var drop:MonsterDrop = null;
         var nbDropsLine:* = 0;
         var dropsList:Array = null;
         var endIndex:* = 0;
         var i:* = 0;
         var result:Array = new Array();
         var monster:Monster = this.dataApi.getMonsterFromId(monsterId);
         var details:Object = 
            {
               "grades":monster.grades,
               "spells":monster.spells,
               "subareas":monster.subareas,
               "hasDrops":true
            };
         var drops:Array = new Array();
         for each(drop in monster.drops)
         {
            if((this.btn_displayCriteriaDrop.selected) || (!drop.hasCriteria))
            {
               drops.push(drop);
            }
         }
         if(!drops.length)
         {
            details.hasDrops = false;
         }
         result.push(details);
         result.push(null);
         result.push(null);
         result.push(null);
         if(drops.length)
         {
            nbDropsLine = Math.ceil(drops.length / NB_DROP_PER_LINE);
            i = 0;
            while(i < nbDropsLine)
            {
               endIndex = (i + 1) * NB_DROP_PER_LINE;
               if(endIndex >= drops.length)
               {
                  dropsList = drops.slice(i * NB_DROP_PER_LINE);
               }
               else
               {
                  dropsList = drops.slice(i * NB_DROP_PER_LINE,endIndex);
               }
               result.push({"dropsList":dropsList});
               i++;
            }
         }
         return result;
      }
      
      private function displayCategories(selectedCategory:Object = null, forceOpen:Boolean = false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function changeSearchOnName() : void {
         this._searchOnName = !this._searchOnName;
         Grimoire.getInstance().bestiarySearchOnName = this._searchOnName;
         if((!this._searchOnName) && (!this._searchOnDrop))
         {
            this.inp_search.visible = false;
            this.tx_inputBg.disabled = true;
         }
         else
         {
            this.inp_search.visible = true;
            this.tx_inputBg.disabled = false;
         }
         if((this._searchCriteria) && (!(this._searchCriteria == "")))
         {
            this.updateMonsterGrid(this.gd_categories.selectedItem);
         }
      }
      
      private function changeSearchOnDrop() : void {
         this._searchOnDrop = !this._searchOnDrop;
         Grimoire.getInstance().bestiarySearchOnDrop = this._searchOnDrop;
         if((!this._searchOnName) && (!this._searchOnDrop))
         {
            this.inp_search.visible = false;
            this.tx_inputBg.disabled = true;
         }
         else
         {
            this.inp_search.visible = true;
            this.tx_inputBg.disabled = false;
         }
         if((this._searchCriteria) && (!(this._searchCriteria == "")))
         {
            this.updateMonsterGrid(this.gd_categories.selectedItem);
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(target == this.gd_categories)
         {
            if(selectMethod != GridItemSelectMethodEnum.AUTO)
            {
               this._searchCriteria = null;
               this.inp_search.text = "";
               this._currentScrollValue = 0;
               this._monstersListToDisplay = new Array();
               if(this._currentCategoryType == CAT_TYPE_AREA)
               {
                  this._lastAreaSelected = target.selectedItem;
               }
               else
               {
                  this._lastRaceSelected = target.selectedItem;
               }
               this.displayCategories(target.selectedItem);
            }
         }
      }
      
      public function onItemRightClick(target:Object, item:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if((item.data) && (!(target.name.indexOf("gd_drops") == -1)))
         {
            data = item.data;
            if((data == null) || (!(data is ItemWrapper)))
            {
               return;
            }
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         var text:String = null;
         var pos:Object = null;
         var data:Object = null;
         var maxGrade:* = 0;
         var percentDrop1:* = NaN;
         var percentDropn:* = NaN;
         var myPp:* = 0;
         var myTruePp:* = 0;
         var myPercentDrop1:* = NaN;
         var myPercentDropn:* = NaN;
         if((item.data) && (!(target.name.indexOf("gd_drops") == -1)))
         {
            pos = 
               {
                  "point":LocationEnum.POINT_BOTTOM,
                  "relativePoint":LocationEnum.POINT_TOP
               };
            data = this._ctrSlotDrop[target.name].dropsList[item.data.position];
            if(item.data is ItemWrapper)
            {
               text = item.data.name;
               text = text + this.averagePricesApi.getItemAveragePriceString(item.data,true);
               maxGrade = this.dataApi.getMonsterFromId(data.monsterId).grades.length;
               if(maxGrade > 5)
               {
                  maxGrade = 5;
               }
               percentDrop1 = this.getRound(data.percentDropForGrade1);
               percentDropn = this.getRound(data["percentDropForGrade" + maxGrade]);
               myTruePp = this.playerApi.characteristics().prospecting.alignGiftBonus + this.playerApi.characteristics().prospecting.base + this.playerApi.characteristics().prospecting.contextModif + this.playerApi.characteristics().prospecting.objectsAndMountBonus;
               myPp = myTruePp;
               if(myTruePp < 100)
               {
                  myPp = 100;
               }
               myPercentDrop1 = this.getRound(percentDrop1 * myPp / 100);
               myPercentDropn = this.getRound(data["percentDropForGrade" + maxGrade] * myPp / 100);
               if(myPercentDrop1 > 100)
               {
                  myPercentDrop1 = 100;
               }
               if(myPercentDropn > 100)
               {
                  myPercentDropn = 100;
               }
               text = text + ("\n" + this.uiApi.getText("ui.monster.obtaining") + " (" + myTruePp + " " + this.uiApi.getText("ui.short.prospection") + ")" + this.uiApi.getText("ui.common.colon") + this.getStringFromValues(myPercentDrop1,myPercentDropn) + "%");
               text = text + ("\n" + this.uiApi.getText("ui.monster.obtaining") + " (" + this.uiApi.getText("ui.common.base") + ")" + this.uiApi.getText("ui.common.colon") + this.getStringFromValues(percentDrop1,percentDropn) + "%");
               if(data.findCeil > 0)
               {
                  text = text + ("\n" + this.uiApi.getText("ui.monster.prospectionThreshold") + this.uiApi.getText("ui.common.colon") + data.findCeil);
               }
            }
            if(text)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:Object) : void {
         var contextMenu:Array = null;
         var data:Object = null;
         var monster:Monster = null;
         var text:String = null;
         var monsterSubAreas:Vector.<uint> = null;
         var subArea:SubArea = null;
         var subAreaId:uint = 0;
         var monsterMiniboss:MonsterMiniBoss = null;
         var monster2:Monster = null;
         switch(target)
         {
            case this.btn_resetSearch:
               this._searchCriteria = null;
               this.inp_search.text = "";
               this.updateMonsterGrid(this.gd_categories.selectedItem);
               break;
            case this.btn_races:
               if(this._currentCategoryType != CAT_TYPE_RACE)
               {
                  this._currentCategoryType = CAT_TYPE_RACE;
                  this.displayCategories(this._lastRaceSelected);
               }
               break;
            case this.btn_subareas:
               if(this._currentCategoryType != CAT_TYPE_AREA)
               {
                  this._currentCategoryType = CAT_TYPE_AREA;
                  this.displayCategories(this._lastAreaSelected);
               }
               break;
            case this.btn_searchFilter:
               contextMenu = new Array();
               contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnName"],this.changeSearchOnName,null,false,null,this._searchOnName,false));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnDrop"],this.changeSearchOnDrop,null,false,null,this._searchOnDrop,false));
               this.modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_displayCriteriaDrop:
               Grimoire.getInstance().bestiaryDisplayCriteriaDrop = this.btn_displayCriteriaDrop.selected;
               this.updateMonsterGrid(this.gd_categories.selectedItem);
               break;
            default:
               if(target.name.indexOf("btn_monster") != -1)
               {
                  if(this.uiApi.keyIsDown(Keyboard.SHIFT))
                  {
                     this.sysApi.dispatchHook(MouseShiftClick,{"data":this._ctrBtnMonster[target.name]});
                     break;
                  }
                  data = this._ctrBtnMonster[target.name];
                  if(this._selectedMonsterId != data.id)
                  {
                     this.gd_monsters.selectedItem = data;
                     this._selectedMonsterId = data.id;
                  }
                  else
                  {
                     this._selectedMonsterId = 0;
                  }
                  this.updateMonsterGrid(this.gd_categories.selectedItem);
                  if(this._searchCriteria != "")
                  {
                  }
               }
               else if(target.name.indexOf("btn_loc") != -1)
               {
                  monster = this._ctrBtnMonsterLocation[target.name];
                  text = this.uiApi.processText(this.uiApi.getText("ui.monster.presentInAreas",monster.subareas.length),"m",monster.subareas.length == 1);
                  monsterSubAreas = new Vector.<uint>(0);
                  for each(subAreaId in monster.subareas)
                  {
                     subArea = this.dataApi.getSubArea(subAreaId);
                     if((subArea.hasCustomWorldMap) || (subArea.area.superArea.hasWorldMap))
                     {
                        monsterSubAreas.push(subAreaId);
                     }
                  }
                  this._mapPopup = this.modCartography.openCartographyPopup(monster.name,monster.favoriteSubareaId,monsterSubAreas,text);
               }
               else if(target.name.indexOf("btn_linkToMonster") != -1)
               {
                  monsterMiniboss = this.dataApi.getMonsterMiniBossFromId(this._ctrTxLink[target.name]);
                  this.onOpenBestiary("bestiaryTab",
                     {
                        "forceOpen":true,
                        "monsterId":monsterMiniboss.monsterReplacingId
                     });
               }
               else if(target.name.indexOf("btn_linkToArch") != -1)
               {
                  monster2 = this.dataApi.getMonsterFromId(this._ctrTxLink[target.name]);
                  this.onOpenBestiary("bestiaryTab",
                     {
                        "forceOpen":true,
                        "monsterId":monster2.correspondingMiniBossId
                     });
               }
               
               
               
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         if(target.name.indexOf("tx_boss") != -1)
         {
            text = this.uiApi.getText("ui.item.boss");
         }
         else if(target.name.indexOf("tx_archMonster") != -1)
         {
            text = this.uiApi.getText("ui.item.miniboss");
         }
         else if(target.name.indexOf("tx_questMonster") != -1)
         {
            text = this.uiApi.getText("ui.monster.questMonster");
         }
         else if(target.name.indexOf("btn_linkToArch") != -1)
         {
            text = this.uiApi.getText("ui.monster.goToArchMonster");
         }
         else if(target.name.indexOf("btn_linkToMonster") != -1)
         {
            text = this.uiApi.getText("ui.monster.goToMonster");
         }
         else if(target.name.indexOf("btn_searchFilter") != -1)
         {
            text = this.uiApi.getText("ui.search.criteria");
         }
         else if(target.name.indexOf("btn_loc") != -1)
         {
            if((target as ButtonContainer).softDisabled)
            {
               return;
            }
            text = this.uiApi.getText("ui.monster.showAreas");
         }
         
         
         
         
         
         
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if(this.inp_search.haveFocus)
         {
            this._lockSearchTimer.reset();
            this._lockSearchTimer.start();
         }
      }
      
      public function onTimeOut(e:TimerEvent) : void {
         if(this.inp_search.text.length > 2)
         {
            this._searchCriteria = this.inp_search.text.toLowerCase();
            this._currentScrollValue = 0;
            this._monstersListToDisplay = new Array();
            this.updateMonsterGrid(this.gd_categories.selectedItem);
         }
         else
         {
            if(this._searchCriteria)
            {
               this._searchCriteria = null;
            }
            if(this.inp_search.text.length == 0)
            {
               this.updateMonsterGrid(this.gd_categories.selectedItem);
            }
         }
      }
      
      private function onCancelSearch() : void {
         clearTimeout(this._searchSettimoutId);
         if(this._progressPopupName)
         {
            this.uiApi.unloadUi(this._progressPopupName);
            this._progressPopupName = null;
         }
      }
      
      private function onOpenBestiary(tab:String = null, param:Object = null) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function getStringFromValues(valueA:Number, valueB:Number) : String {
         if(valueA == valueB)
         {
            return "" + valueA;
         }
         return "" + valueA + " " + this.uiApi.getText("ui.chat.to") + " " + valueB;
      }
      
      private function getRound(value:Number) : Number {
         return Math.round(value * 1000) / 1000;
      }
   }
}
