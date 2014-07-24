package 
{
   import flash.utils.Dictionary;
   import d2actions.*;
   import d2enums.FightEventEnum;
   
   public class FightTexts extends Object
   {
      
      public function FightTexts() {
         super();
      }
      
      public static var cacheFighterName:Dictionary;
      
      public static var cacheSpellName:Dictionary;
      
      private static var _targets:Vector.<int>;
      
      private static var _targetsTeam:String;
      
      private static var _logBuffer:String = "";
      
      public static function writeLog() : void {
      }
      
      private static function getSpellName(casterId:int, targetCellId:int, sourceCellId:int, spellId:uint, spellLevelId:uint) : String {
         var spellName:String = cacheSpellName[spellId];
         if(!spellName)
         {
            spellName = Api.dataApi.getSpell(spellId).name;
            cacheSpellName[spellId] = spellName;
         }
         var eventParams:String = "event:spellEffectArea," + casterId + "," + targetCellId + "," + sourceCellId + "," + spellId + "," + spellLevelId;
         spellName = Api.chatApi.addHtmlLink(spellName,eventParams);
         return spellName;
      }
      
      private static function getFighterName(id:int) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private static function getFighterCacheName(id:int) : String {
         var fighterName:String = cacheFighterName[id];
         if(!fighterName)
         {
            if(id > 0)
            {
               fighterName = Api.chatApi.addHtmlLink(Api.fightApi.getFighterName(id),"event:entity," + id + ",1");
            }
            else if(id < 0)
            {
               fighterName = Api.chatApi.addHtmlLink(Api.fightApi.getFighterName(id),"event:monsterFight," + id);
            }
            
            cacheFighterName[id] = fighterName;
         }
         return fighterName;
      }
      
      public static function event(name:String, params:Object, pTargets:Object = null, pTargetsTeam:String = "") : void {
         var roobjectdata:* = 0;
         var delta:String = null;
         var duration:* = 0;
         var finalText:String = null;
         var turnText:String = null;
         var statLost:Array = null;
         _targets = new Vector.<int>();
         if(pTargets != null)
         {
            for each(roobjectdata in pTargets)
            {
               if(_targets.indexOf(roobjectdata) == -1)
               {
                  _targets.push(roobjectdata);
               }
            }
         }
         _targetsTeam = pTargetsTeam;
         var txt:String = "";
         switch(name)
         {
            case FightEventEnum.FIGHTER_LIFE_LOSS_AND_DEATH:
               txt = Api.uiApi.getText("ui.fight.lifeLossAndDeath",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_LIFE_LOSS:
               txt = Api.uiApi.getText("ui.fight.lifeLoss",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_LIFE_GAIN:
               txt = Api.uiApi.getText("ui.fight.lifeGain",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_NO_CHANGE:
               txt = Api.uiApi.getText("ui.fight.noChange",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHT_END:
               txt = Api.uiApi.getText("ui.fight.fightEnd");
               break;
            case FightEventEnum.FIGHTER_DEATH:
               txt = Api.uiApi.getText("ui.fight.isDead",_targetsTeam?getFighterName(params[0]):params[1]);
               txt = Api.uiApi.processText(txt,"n",true);
               break;
            case FightEventEnum.FIGHTER_LEAVE:
               txt = Api.uiApi.getText("ui.fight.leave",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_CHANGE_LOOK:
               break;
            case FightEventEnum.FIGHTER_GOT_DISPELLED:
               txt = Api.uiApi.getText("ui.fight.dispell",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_SPELL_DISPELLED:
               txt = Api.uiApi.getText("ui.fight.dispellSpell",getFighterName(params[0]),Api.dataApi.getSpell(params[1]).name);
               break;
            case FightEventEnum.FIGHTER_EFFECTS_MODIFY_DURATION:
               txt = Api.uiApi.getText("ui.fight.effectsModifyDuration",getFighterName(params[1]),params[2]);
               break;
            case FightEventEnum.FIGHTER_SPELL_COOLDOWN_VARIATION:
               delta = params[2] < 0?params[2]:"+" + params[2];
               txt = Api.uiApi.getText("ui.fight.cooldownVariation",getFighterName(params[0]),Api.dataApi.getSpell(params[1]).name,delta);
               break;
            case FightEventEnum.FIGHTER_SPELL_IMMUNITY:
               txt = Api.uiApi.getText("ui.fight.noChange",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_AP_LOSS_DODGED:
               txt = Api.uiApi.getText("ui.fight.dodgeAP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_MP_LOSS_DODGED:
               txt = Api.uiApi.getText("ui.fight.dodgeMP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTERS_POSITION_EXCHANGE:
               break;
            case FightEventEnum.FIGHTER_VISIBILITY_CHANGED:
               switch(params[1])
               {
                  case 1:
                     txt = Api.uiApi.getText("ui.fight.invisibility",getFighterName(params[0]));
                     break;
                  case 2:
                  case 3:
                     txt = Api.uiApi.getText("ui.fight.visibility",getFighterName(params[0]));
                     break;
               }
               break;
            case FightEventEnum.FIGHTER_INVISIBLE_OBSTACLE:
               txt = Api.uiApi.getText("ui.fight.invisibleObstacle",getFighterName(params[0]),Api.dataApi.getSpellLevel(params[1]).spell.name);
               break;
            case FightEventEnum.FIGHTER_GOT_KILLED:
               if(params[0] != params[1])
               {
                  txt = Api.uiApi.getText("ui.fight.killed",getFighterCacheName(params[0]),getFighterName(params[1]));
               }
               break;
            case FightEventEnum.FIGHTER_TEMPORARY_BOOSTED:
               duration = int(params[2]);
               finalText = params[1];
               if(duration)
               {
                  finalText = finalText + " (" + params[3] + ")";
               }
               txt = Api.uiApi.getText("ui.fight.effect",getFighterName(params[0]),finalText);
               break;
            case FightEventEnum.FIGHTER_AP_USED:
               break;
            case FightEventEnum.FIGHTER_AP_LOST:
               txt = Api.uiApi.getText("ui.fight.lostAP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_AP_GAINED:
               txt = Api.uiApi.getText("ui.fight.winAP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_MP_USED:
               break;
            case FightEventEnum.FIGHTER_MP_LOST:
               txt = Api.uiApi.getText("ui.fight.lostMP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_MP_GAINED:
               txt = Api.uiApi.getText("ui.fight.winMP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_SHIELD_LOSS:
               txt = Api.uiApi.getText("ui.fight.lostShieldPoints",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_REDUCED_DAMAGES:
               txt = Api.uiApi.getText("ui.fight.reduceDamages",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_REFLECTED_DAMAGES:
               txt = Api.uiApi.getText("ui.fight.reflectDamages",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_REFLECTED_SPELL:
               txt = Api.uiApi.getText("ui.fight.reflectSpell",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_SLIDE:
               break;
            case FightEventEnum.FIGHTER_CASTED_SPELL:
               txt = Api.uiApi.getText("ui.fight.launchSpell",getFighterName(params[0]),getSpellName(params[0],params[1],params[2],params[3],params[4]));
               if(params[5] == 2)
               {
                  txt = txt + (" " + Api.uiApi.getText("ui.fight.criticalHit"));
               }
               else if(params[5] == 3)
               {
                  txt = txt + (" " + Api.uiApi.getText("ui.fight.criticalMiss"));
               }
               
               break;
            case FightEventEnum.FIGHTER_CLOSE_COMBAT:
               txt = Api.uiApi.getText("ui.fight.closeCombat",getFighterName(params[0]),Api.dataApi.getItem(params[1]).name);
               if(params[2] == 2)
               {
                  txt = txt + (" " + Api.uiApi.getText("ui.fight.criticalHit"));
               }
               else if(params[2] == 3)
               {
                  txt = txt + (" " + Api.uiApi.getText("ui.fight.criticalMiss"));
               }
               
               break;
            case FightEventEnum.FIGHTER_DID_CRITICAL_HIT:
               break;
            case FightEventEnum.FIGHTER_ENTERING_STATE:
               turnText = "";
               if((params.length == 3) && (params[2]))
               {
                  turnText = "</b> (" + params[2] + ")<b>";
               }
               txt = Api.uiApi.getText("ui.fight.enterState",getFighterName(params[0]),Api.dataApi.getSpellState(params[1]).name + turnText);
               break;
            case FightEventEnum.FIGHTER_LEAVING_STATE:
               txt = Api.uiApi.getText("ui.fight.exitState",getFighterName(params[0]),Api.dataApi.getSpellState(params[1]).name);
               break;
            case FightEventEnum.FIGHTER_STEALING_KAMAS:
               txt = Api.uiApi.getText("ui.fight.stealMoney",getFighterCacheName(params[0]),params[2],getFighterName(params[1]));
               txt = Api.uiApi.processText(txt,"n",params[2] <= 1);
               break;
            case FightEventEnum.FIGHTER_SUMMONED:
               break;
            case FightEventEnum.FIGHTER_GOT_TACKLED:
               txt = Api.uiApi.getText("ui.fight.dodgeFailed");
               if(params.length > 1)
               {
                  statLost = new Array();
                  if((params[1]) && (!(params[1] == 0)))
                  {
                     statLost.push("-" + params[1] + " " + Api.uiApi.getText("ui.common.ap"));
                  }
                  if((params[2]) && (!(params[2] == 0)))
                  {
                     statLost.push("-" + params[2] + " " + Api.uiApi.getText("ui.common.mp"));
                  }
                  txt = txt + (" (" + statLost.join(",") + ")");
               }
               break;
            case FightEventEnum.FIGHTER_TELEPORTED:
               break;
            case FightEventEnum.FIGHTER_TRIGGERED_GLYPH:
               txt = Api.uiApi.getText("ui.fight.startTrap",getFighterName(params[0]),Api.dataApi.getSpell(params[2]).name,getFighterName(params[1]));
               break;
            case FightEventEnum.FIGHTER_TRIGGERED_TRAP:
               txt = Api.uiApi.getText("ui.fight.startTrap",getFighterName(params[0]),Api.dataApi.getSpell(params[2]).name,getFighterName(params[1]));
               break;
            case FightEventEnum.GLYPH_APPEARED:
               break;
            case FightEventEnum.GLYPH_DISAPPEARED:
               break;
            case FightEventEnum.TRAP_APPEARED:
               break;
            case FightEventEnum.TRAP_DISAPPEARED:
               break;
            case FightEventEnum.FIGHTER_CARRY:
               break;
            case FightEventEnum.FIGHTER_THROW:
               break;
            default:
               Api.sysApi.log(16,"Unknown fight event " + name + " received.");
               return;
         }
         if((txt) && (txt.length > 0))
         {
            Api.sysApi.sendAction(new FightOutput(txt,11));
         }
      }
   }
}
