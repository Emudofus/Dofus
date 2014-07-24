package ui
{
   import d2api.SystemApi;
   import d2api.TimeApi;
   import d2api.UiApi;
   import d2api.PlayedCharacterApi;
   import d2api.SoundApi;
   import d2api.AveragePricesApi;
   import d2api.UtilApi;
   import d2api.TooltipApi;
   import d2api.ContextMenuApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.Grid;
   import d2components.Texture;
   import flash.utils.Dictionary;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2enums.FightTypeEnum;
   import d2enums.FightOutcomeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   import d2utils.ItemTooltipSettings;
   
   public class FightResult extends Object
   {
      
      public function FightResult() {
         this._pictoUris = new Array();
         this._objectsLists = new Dictionary(true);
         this._hookGridObjects = new Dictionary(true);
         super();
      }
      
      private static const RESULT_COMPLETE:uint = 1;
      
      private static const RESULT_FAILED:uint = 2;
      
      private static const MAXIMAL_SIZE:uint = 20;
      
      private static var CTR_TYPE_TITLE:String = "ctr_title";
      
      private static var CTR_TYPE_FIGHTER:String = "ctr_fighter";
      
      public var sysApi:SystemApi;
      
      public var timeApi:TimeApi;
      
      public var uiApi:UiApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var soundApi:SoundApi;
      
      public var averagePricesApi:AveragePricesApi;
      
      public var utilApi:UtilApi;
      
      public var tooltipApi:TooltipApi;
      
      public var menuApi:ContextMenuApi;
      
      public var modContextMenu:Object;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_stars:GraphicContainer;
      
      public var ctr_drop:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_close2:ButtonContainer;
      
      public var btn_closeDrop:ButtonContainer;
      
      public var lbl_result:Label;
      
      public var lbl_time:Label;
      
      public var lbl_titleBonus:Label;
      
      public var lbl_sizeMalus:Label;
      
      public var lbl_honour:Label;
      
      public var lbl_drop:Label;
      
      public var gd_fighters:Grid;
      
      public var gd_drop:Grid;
      
      public var tx_star0:Texture;
      
      public var tx_star1:Texture;
      
      public var tx_star2:Texture;
      
      public var tx_star3:Texture;
      
      public var tx_star4:Texture;
      
      public var tx_challenge1:Texture;
      
      public var tx_challenge2:Texture;
      
      public var tx_challenge_result1:Texture;
      
      public var tx_challenge_result2:Texture;
      
      public var tx_background:Texture;
      
      public var tx_bgResult:Texture;
      
      public var tx_gridDeco:Texture;
      
      private var _challenges:Array;
      
      private var _ageBonus:int;
      
      private var _sizeMalus:int;
      
      private var _isPvpFight:Boolean;
      
      private var _winnersName:String;
      
      private var _losersName:String;
      
      private var _heightBg:int;
      
      private var _heightGrid:int;
      
      private var _heightGridBg:int;
      
      private var _heightLine:int;
      
      private var _widthName:int;
      
      private var _pictoUris:Array;
      
      private var _objectsLists:Dictionary;
      
      private var _hookGridObjects:Dictionary;
      
      public function main(params:Object) : void {
         this.uiApi.addComponentHook(this.tx_challenge1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_challenge1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_challenge2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_challenge2,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_challenge_result1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_challenge_result1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_challenge_result2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_challenge_result2,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_sizeMalus,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_sizeMalus,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_stars,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_stars,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_drop,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_drop,ComponentHookList.ON_ITEM_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.gd_drop,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_drop,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.ctr_drop.visible = false;
         var duration:int = params.duration;
         this._ageBonus = params.ageBonus;
         this._sizeMalus = params.sizeMalus;
         var results:Object = params.results;
         this._challenges = params.challenges;
         this._winnersName = params.winnersName;
         this._losersName = params.losersName;
         this._pictoUris.push(this.uiApi.me().getConstant("winner_uri"));
         this._pictoUris.push(this.uiApi.me().getConstant("loser_uri"));
         this._pictoUris.push(this.uiApi.me().getConstant("pony_uri"));
         this._heightBg = int(this.uiApi.me().getConstant("bg_height"));
         this._heightGrid = int(this.uiApi.me().getConstant("grid_height"));
         this._heightGridBg = int(this.uiApi.me().getConstant("gridBg_height"));
         this._heightLine = int(this.uiApi.me().getConstant("line_height"));
         this._widthName = int(this.uiApi.me().getConstant("name_width"));
         var turns:String = " (" + this.uiApi.getText("ui.fight.turnCount",params.turns) + ")";
         if(params.turns > 1)
         {
            turns = this.uiApi.processText(turns,"m",false);
         }
         else
         {
            turns = this.uiApi.processText(turns,"m",true);
         }
         this.lbl_time.text = this.timeApi.getShortDuration(duration,true) + turns;
         if((params.fightType == FightTypeEnum.FIGHT_TYPE_AGRESSION) || (params.fightType == FightTypeEnum.FIGHT_TYPE_PvMA))
         {
            this._isPvpFight = true;
         }
         this.lbl_honour.visible = this._isPvpFight;
         this.displayBonuses();
         this.displayChallenges();
         this.displayResults(results);
      }
      
      public function unload() : void {
         this.sysApi.dispatchHook(FightResultClosed);
      }
      
      public function updateLine(data:*, compRef:*, selected:Boolean, line:uint) : void {
         var percentXp:* = 0;
         var objects:Array = null;
         var o:Object = null;
         var objectsList:String = null;
         var obj:* = undefined;
         switch(this.getLineType(data,line))
         {
            case CTR_TYPE_TITLE:
               compRef.tx_titleIcon.uri = this.uiApi.createUri(this._pictoUris[data.icon]);
               compRef.lbl_titleName.text = data.name;
               if(this._isPvpFight)
               {
                  compRef.tx_honourVLine.visible = true;
               }
               else
               {
                  compRef.tx_honourVLine.visible = false;
               }
               break;
            case CTR_TYPE_FIGHTER:
               if(!this._hookGridObjects[compRef.gd_objects.name])
               {
                  this.uiApi.addComponentHook(compRef.gd_objects,ComponentHookList.ON_ITEM_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.gd_objects,ComponentHookList.ON_ITEM_ROLL_OUT);
                  this.uiApi.addComponentHook(compRef.gd_objects,ComponentHookList.ON_SELECT_ITEM);
                  this.uiApi.addComponentHook(compRef.gd_objects,ComponentHookList.ON_ITEM_RIGHT_CLICK);
               }
               this._hookGridObjects[compRef.gd_objects.name] = data;
               if(!this._hookGridObjects[compRef.btn_seeMore.name])
               {
                  this.uiApi.addComponentHook(compRef.btn_seeMore,ComponentHookList.ON_RELEASE);
                  this.uiApi.addComponentHook(compRef.btn_seeMore,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.btn_seeMore,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.btn_seeMore.name] = data;
               if(!this._hookGridObjects[compRef.tx_xpGauge.name])
               {
                  this.uiApi.addComponentHook(compRef.tx_xpGauge,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.tx_xpGauge,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.tx_xpGauge.name] = data;
               if(!this._hookGridObjects[compRef.tx_xpBonusPicto.name])
               {
                  this.uiApi.addComponentHook(compRef.tx_xpBonusPicto,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.tx_xpBonusPicto,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.tx_xpBonusPicto.name] = data;
               if(!this._hookGridObjects[compRef.lbl_xpPerso.name])
               {
                  this.uiApi.addComponentHook(compRef.lbl_xpPerso,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.lbl_xpPerso,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.lbl_xpPerso.name] = data;
               if(!this._hookGridObjects[compRef.lbl_honour.name])
               {
                  this.uiApi.addComponentHook(compRef.lbl_honour,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.lbl_honour,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.lbl_honour.name] = data;
               if(!this._hookGridObjects[compRef.tx_arrow.name])
               {
                  this.uiApi.addComponentHook(compRef.tx_arrow,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.tx_arrow,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.tx_arrow.name] = data;
               compRef.tx_deathPicto.visible = !data.alive;
               if((data.id == this.playerApi.id()) || (data.fightInitiator))
               {
                  compRef.tx_arrow.visible = true;
                  compRef.lbl_name.width = this._widthName - compRef.tx_arrow.width - 3;
                  if(data.fightInitiator)
                  {
                     compRef.tx_arrow.gotoAndStop = 2;
                  }
                  else
                  {
                     compRef.tx_arrow.gotoAndStop = 1;
                  }
               }
               else
               {
                  compRef.tx_arrow.visible = false;
               }
               if(data.type == 0)
               {
                  compRef.lbl_name.text = "{player," + data.name + "," + data.id + "::" + data.name + "}";
               }
               else
               {
                  compRef.lbl_name.text = data.name;
               }
               compRef.lbl_level.text = data.level;
               if(data.showExperience)
               {
                  compRef.tx_xpGauge.visible = true;
                  percentXp = Math.floor((data.experience - data.experienceLevelFloor) * 100 / (data.experienceNextLevelFloor - data.experienceLevelFloor));
                  compRef.tx_xpGauge.gotoAndStop = percentXp.toString();
                  compRef.lbl_xpPerso.x = this.uiApi.me().getConstant("lbl_xp_short_x");
                  compRef.lbl_xpPerso.width = this.uiApi.me().getConstant("lbl_xp_short_width");
               }
               else
               {
                  compRef.tx_xpGauge.visible = false;
                  compRef.lbl_xpPerso.x = this.uiApi.me().getConstant("lbl_xp_long_x");
                  compRef.lbl_xpPerso.width = this.uiApi.me().getConstant("lbl_xp_long_width");
               }
               if(data.honorDelta == -1)
               {
                  compRef.lbl_honour.visible = false;
                  compRef.tx_honourVLine.visible = false;
               }
               else
               {
                  compRef.lbl_honour.visible = true;
                  compRef.tx_honourVLine.visible = true;
                  compRef.lbl_honour.text = data.honorDelta;
               }
               if((data.honorDelta == -1) && (!(data.rerollXpMultiplicator == 0)))
               {
                  compRef.tx_xpBonusPicto.visible = true;
                  compRef.tx_xpBonusPicto.gotoAndStop = data.rerollXpMultiplicator.toString();
               }
               else
               {
                  compRef.tx_xpBonusPicto.visible = false;
               }
               if(data.showExperienceFightDelta)
               {
                  compRef.lbl_xpPerso.text = this.utilApi.kamasToString(data.experienceFightDelta,"");
               }
               else
               {
                  compRef.lbl_xpPerso.text = "";
               }
               if(data.rewards.kamas > 0)
               {
                  compRef.lbl_kamas.text = this.utilApi.kamasToString(data.rewards.kamas,"");
               }
               else if(data.type != 0)
               {
                  compRef.lbl_kamas.text = "";
               }
               else
               {
                  compRef.lbl_kamas.text = "0";
               }
               
               if(data.rewards.objects.length > 0)
               {
                  objects = new Array();
                  for each(o in data.rewards.objects)
                  {
                     objects.push(o);
                  }
                  compRef.gd_objects.dataProvider = objects;
               }
               else
               {
                  compRef.gd_objects.dataProvider = new Array();
               }
               if(data.rewards.objects.length > 10)
               {
                  compRef.btn_seeMore.visible = true;
                  objectsList = "";
                  for each(obj in data.rewards.objects)
                  {
                     objectsList = objectsList + (obj.quantity + " x " + obj.name + " \n");
                  }
                  this._objectsLists[data.id] = objectsList;
               }
               else
               {
                  compRef.btn_seeMore.visible = false;
               }
               if(data.isLastOfHisWave)
               {
                  compRef.ctr_waveLine.visible = true;
               }
               else
               {
                  compRef.ctr_waveLine.visible = false;
               }
               break;
         }
      }
      
      public function getLineType(data:*, line:uint) : String {
         if(!data)
         {
            return "";
         }
         switch(line)
         {
            case 0:
               if((data) && (data.hasOwnProperty("level")))
               {
                  return CTR_TYPE_FIGHTER;
               }
               return CTR_TYPE_TITLE;
            default:
               return CTR_TYPE_TITLE;
         }
      }
      
      public function getDataLength(data:*, selected:Boolean) : * {
         if(selected)
         {
            trace(data.title + " : " + (2 + (selected?data.subcats.length:0)));
         }
         return 2 + (selected?data.subcats.length:0);
      }
      
      public function displayBonuses() : void {
         var stars_degree:* = 0;
         var bonus:* = 0;
         var numStars:* = 0;
         var i:* = 0;
         var tx_star:Texture = null;
         if(this._ageBonus <= 0)
         {
            this.ctr_stars.visible = false;
            if(this._sizeMalus <= 0)
            {
               this.lbl_titleBonus.text = this.uiApi.getText("ui.fightend.noBonus");
            }
            else
            {
               this.lbl_titleBonus.text = this.uiApi.getText("ui.fightend.malus") + this.uiApi.getText("ui.common.colon");
               this.lbl_sizeMalus.visible = true;
               this.lbl_sizeMalus.text = "-" + this._sizeMalus + "%";
            }
         }
         else
         {
            stars_degree = 0;
            bonus = this._ageBonus;
            this.ctr_stars.visible = true;
            this.lbl_sizeMalus.visible = false;
            this.lbl_titleBonus.text = this.uiApi.getText("ui.fightend.bonus") + this.uiApi.getText("ui.common.colon");
            if(bonus > 100)
            {
               stars_degree = 1;
               bonus = bonus - 100;
            }
            numStars = Math.round(bonus / 20);
            i = 0;
            while(i < numStars)
            {
               tx_star = this["tx_star" + i];
               tx_star.uri = this.uiApi.createUri(this.uiApi.me().getConstant("star_uri" + (1 + stars_degree)));
               tx_star.finalize();
               i++;
            }
            i = i;
            while(i < 5)
            {
               tx_star = this["tx_star" + i];
               tx_star.uri = this.uiApi.createUri(this.uiApi.me().getConstant("star_uri" + stars_degree));
               tx_star.finalize();
               i++;
            }
         }
      }
      
      public function displayChallenge(ctr_challenge:Object, challenge:Object) : void {
         ctr_challenge.tx_challenge.visible = true;
         ctr_challenge.tx_challenge.uri = challenge.iconUri;
         switch(challenge.result)
         {
            case RESULT_COMPLETE:
               ctr_challenge.tx_challenge_result.visible = true;
               ctr_challenge.tx_challenge_result.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "Challenge_tx_Gagne");
               break;
            case RESULT_FAILED:
               ctr_challenge.tx_challenge_result.visible = true;
               ctr_challenge.tx_challenge_result.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "Challenge_tx_Perdu");
               break;
         }
      }
      
      public function displayChallenges() : void {
         var ctr_challenges:Array = [
            {
               "tx_challenge":this.tx_challenge1,
               "tx_challenge_result":this.tx_challenge_result1
            },
            {
               "tx_challenge":this.tx_challenge2,
               "tx_challenge_result":this.tx_challenge_result2
            }];
         var i:int = 0;
         while(i < ctr_challenges.length)
         {
            ctr_challenges[i].tx_challenge.visible = false;
            ctr_challenges[i].tx_challenge_result.visible = false;
            i++;
         }
         var maxChallenge:uint = this._challenges.length <= 2?this._challenges.length:2;
         i = 0;
         while(i < maxChallenge)
         {
            this.displayChallenge(ctr_challenges[i],this._challenges[i]);
            i++;
         }
      }
      
      public function displayResults(results:Object) : void {
         var i:* = undefined;
         var winnersStr:String = null;
         var w:Object = null;
         var losersStr:String = null;
         var l:Object = null;
         var p:Object = null;
         var heightToRemove:* = 0;
         var dataprovider:Array = new Array();
         var winners:Array = new Array();
         var losers:Array = new Array();
         var pony:Array = new Array();
         for(i in results)
         {
            results[i].rewards.objects.sort(this.compareItemsAveragePrices);
            if(results[i].outcome == FightOutcomeEnum.RESULT_VICTORY)
            {
               winners.push(results[i]);
               if(results[i].id == this.playerApi.id())
               {
                  this.lbl_result.text = this.uiApi.getText("ui.fightend.victory");
                  this.soundApi.playSound(SoundTypeEnum.FIGHT_WIN);
               }
            }
            else if(results[i].outcome == FightOutcomeEnum.RESULT_LOST)
            {
               losers.push(results[i]);
               if(results[i].id == this.playerApi.id())
               {
                  this.lbl_result.text = this.uiApi.getText("ui.fightend.loss");
                  this.soundApi.playSound(SoundTypeEnum.FIGHT_LOSE);
               }
            }
            else if(results[i].outcome == FightOutcomeEnum.RESULT_TAX)
            {
               pony.push(results[i]);
            }
            
            
         }
         winnersStr = !(this._winnersName == "")?this._winnersName:this.uiApi.getText("ui.fightend.winners");
         dataprovider.push(
            {
               "name":winnersStr,
               "icon":0
            });
         for each(w in winners)
         {
            dataprovider.push(w);
         }
         losersStr = !(this._losersName == "")?this._losersName:this.uiApi.getText("ui.fightend.losers");
         dataprovider.push(
            {
               "name":losersStr,
               "icon":1
            });
         for each(l in losers)
         {
            dataprovider.push(l);
         }
         if(pony.length > 0)
         {
            dataprovider.push(
               {
                  "name":this.uiApi.getText("ui.common.taxCollector"),
                  "icon":2
               });
            for each(p in pony)
            {
               dataprovider.push(p);
            }
         }
         if(dataprovider.length < MAXIMAL_SIZE)
         {
            heightToRemove = (MAXIMAL_SIZE - dataprovider.length) * this._heightLine;
            this.tx_background.height = this._heightBg - heightToRemove;
            this.tx_bgResult.height = this._heightGridBg - heightToRemove;
            this.gd_fighters.height = this._heightGrid - heightToRemove;
            this.tx_gridDeco.height = this._heightGridBg - heightToRemove;
            this.uiApi.me().render();
         }
         this.gd_fighters.dataProvider = dataprovider;
      }
      
      private function compareItemsAveragePrices(pItemA:Object, pItemB:Object) : int {
         var itemAPrice:int = this.averagePricesApi.getItemAveragePrice(pItemA.objectGID) * pItemA.quantity;
         var itemBPrice:int = this.averagePricesApi.getItemAveragePrice(pItemB.objectGID) * pItemB.quantity;
         return itemAPrice < itemBPrice?1:itemAPrice > itemBPrice?-1:0;
      }
      
      public function onRelease(target:Object) : void {
         var data:Object = null;
         switch(target)
         {
            case this.btn_close:
            case this.btn_close2:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_closeDrop:
               this.ctr_drop.visible = false;
               break;
            default:
               if(target.name.indexOf("btn_seeMore") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if((this.ctr_drop.visible) && (this.lbl_drop.text == data.name))
                  {
                     this.ctr_drop.visible = false;
                  }
                  else
                  {
                     this.ctr_drop.visible = true;
                     this.gd_drop.dataProvider = data.rewards.objects;
                     this.lbl_drop.text = data.name;
                  }
               }
         }
      }
      
      public function onRollOver(target:Object) : void {
         var data:Object = null;
         var percentXp:* = 0;
         var bonusXp:* = 0;
         var text:String = "";
         var pos:Object = 
            {
               "point":7,
               "relativePoint":7,
               "offset":0
            };
         switch(target)
         {
            case this.tx_challenge_result1:
               this.uiApi.showTooltip(this._challenges[0],target,false,"standard",2,8,0,null,null,null);
               break;
            case this.tx_challenge_result2:
               this.uiApi.showTooltip(this._challenges[1],target,false,"standard",2,8,0,null,null,null);
               break;
            case this.ctr_stars:
               text = this.uiApi.getText("ui.fightend.bonus") + this.uiApi.getText("ui.common.colon") + this._ageBonus + "%";
               break;
            case this.lbl_sizeMalus:
               text = this.uiApi.getText("ui.fightend.sizeMalus",this._sizeMalus);
               break;
            default:
               if(target.name.indexOf("btn_seeMore") != -1)
               {
                  text = this._objectsLists[this._hookGridObjects[target.name].id];
               }
               else if(target.name.indexOf("lbl_honour") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     text = this.uiApi.getText("ui.pvp.rank") + this.uiApi.getText("ui.common.colon") + data.grade + "\n" + this.uiApi.getText("ui.pvp.honourPoints") + this.uiApi.getText("ui.common.colon") + (data.honorDelta > 0?"+":"") + data.honorDelta;
                  }
               }
               else if(target.name.indexOf("lbl_xpPerso") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     if(data.showExperienceFightDelta)
                     {
                        text = this.uiApi.getText("ui.fightend.xp") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(data.experienceFightDelta,"");
                        if(data.isIncarnationExperience)
                        {
                           text = text + (" (" + this.uiApi.getText("ui.common.incarnation") + ")");
                        }
                     }
                     if(data.showExperienceForGuild)
                     {
                        text = text + ("\n" + this.uiApi.getText("ui.common.guild") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(data.experienceForGuild,""));
                     }
                     if(data.showExperienceForRide)
                     {
                        text = text + ("\n" + this.uiApi.getText("ui.common.ride") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(data.experienceForRide,""));
                     }
                  }
               }
               else if(target.name.indexOf("tx_xpGauge") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     percentXp = Math.floor((data.experience - data.experienceLevelFloor) * 100 / (data.experienceNextLevelFloor - data.experienceLevelFloor));
                     text = "" + percentXp + "% (" + this.utilApi.kamasToString(data.experience - data.experienceLevelFloor,"") + " / " + this.utilApi.kamasToString(data.experienceNextLevelFloor - data.experienceLevelFloor,"") + ")";
                  }
               }
               else if(target.name.indexOf("tx_xpBonusPicto") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     bonusXp = data.rerollXpMultiplicator;
                     if(bonusXp > 1)
                     {
                        text = this.uiApi.getText("ui.common.experiencePoint") + " x " + bonusXp + "\n\n" + this.uiApi.getText("ui.information.xpFamilyBonus");
                     }
                  }
               }
               else if(target.name.indexOf("tx_arrow") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     if(data.fightInitiator)
                     {
                        text = this.uiApi.getText("ui.fightend.fightInitiator");
                     }
                  }
               }
               
               
               
               
               
         }
         if(text != "")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,pos.offset,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var item:Object = null;
         if((!(target.name.indexOf("gd_objects") == -1)) || (target == this.gd_drop))
         {
            if((!this.sysApi.getOption("displayTooltips","dofus")) && ((selectMethod == GridItemSelectMethodEnum.CLICK) || (selectMethod == GridItemSelectMethodEnum.MANUAL)))
            {
               item = target.selectedItem;
               this.sysApi.dispatchHook(ShowObjectLinked,item);
            }
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         var itemTooltipSettings:ItemTooltipSettings = null;
         var tooltipData:* = undefined;
         if(item.data)
         {
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",true) as ItemTooltipSettings;
            if(!itemTooltipSettings)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,true);
            }
            tooltipData = item.data;
            if((!itemTooltipSettings.header) && (!itemTooltipSettings.conditions) && (!itemTooltipSettings.effects) && (!itemTooltipSettings.description) && (!itemTooltipSettings.averagePrice))
            {
               tooltipData = item.data.name;
            }
            this.uiApi.showTooltip(item.data,item.container,false,"standard",7,7,0,"itemName",null,
               {
                  "header":itemTooltipSettings.header,
                  "conditions":itemTooltipSettings.conditions,
                  "description":itemTooltipSettings.description,
                  "averagePrice":itemTooltipSettings.averagePrice,
                  "showEffects":itemTooltipSettings.effects
               },"ItemInfo");
         }
      }
      
      public function onItemRightClick(target:Object, item:Object) : void {
         if(item.data == null)
         {
            return;
         }
         var data:Object = item.data;
         var contextMenu:Object = this.menuApi.create(data);
         var itemTooltipSettings:ItemTooltipSettings = this.sysApi.getData("itemTooltipSettings",true) as ItemTooltipSettings;
         if(!itemTooltipSettings)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,true);
         }
         this.modContextMenu.createContextMenu(contextMenu);
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onItemDetails(item:Object, target:Object) : void {
         this.uiApi.showTooltip(item,target,false,"Hyperlink",0,2,3,null,null,null,null,true);
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
            case "closeUi":
               if(this.ctr_drop.visible)
               {
                  this.ctr_drop.visible = false;
               }
               else
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function onGameFightEnd(params:Object) : void {
      }
   }
}
