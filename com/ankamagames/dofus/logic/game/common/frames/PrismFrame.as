package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.prism.PrismSubAreaInformation;
   import com.ankamagames.dofus.network.types.game.prism.VillageConquestPrismInformation;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismFightersWrapper;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightJoinLeaveRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightJoinLeaveRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightSwapRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightSwapRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismInfoJoinLeaveRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismInfoJoinLeaveRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismWorldInformationRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismWorldInformationRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismBalanceRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismBalanceRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismCurrentBonusRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismCurrentBonusRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismAttackRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismAttackRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismUseRequestAction;
   import com.ankamagames.dofus.network.messages.game.prism.PrismUseRequestMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismBalanceResultMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismAlignmentBonusResultMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightDefendersStateMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightDefenderAddMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightDefenderLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightDefendersSwapMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightAttackedMessage;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightAttackerAddMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightAttackerRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismWorldInformationMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.AlignmentSubAreaUpdateExtendedMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismInfoCloseMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismInfoValidMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismInfoInValidMessage;
   import com.ankamagames.dofus.network.messages.game.prism.PrismFightStateUpdateMessage;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookAndGradeInformations;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.enums.SubareaUpdateEventEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismConquestWrapper;


   public class PrismFrame extends Object implements Frame
   {
         

      public function PrismFrame() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PrismFrame));

      private var _subAreaBalanceValue:uint;

      private var _totalBalanceValue:uint;

      private var _nbSubOwned:uint;

      private var _subTotal:uint;

      private var _maxSub:uint;

      private var _subAreasInformation:Vector.<PrismSubAreaInformation>;

      private var _nbConqsOwned:uint;

      private var _conqsTotal:uint;

      private var _conquetesInformation:Vector.<VillageConquestPrismInformation>;

      private var _mapId:int = 0;

      private var _subareaId:int = 0;

      private var _worldX:int = 0;

      private var _worldY:int = 0;

      private var _fightId:uint = 0;

      private var _prismState:int = 0;

      private var _attackers:Array;

      private var _defenders:Array;

      private var _reserves:Array;

      private var _infoJoinLeave:Boolean;

      public function get priority() : int {
         return Priority.NORMAL;
      }

      public function get nbSubOwned() : uint {
         return this._nbSubOwned;
      }

      public function get subTotal() : uint {
         return this._subTotal;
      }

      public function get maxSub() : uint {
         return this._maxSub;
      }

      public function get nbConqsOwned() : uint {
         return this._nbConqsOwned;
      }

      public function get conqsTotal() : uint {
         return this._conqsTotal;
      }

      public function get totalBalanceValue() : uint {
         return this._totalBalanceValue;
      }

      public function get subAreaBalanceValue() : uint {
         return this._subAreaBalanceValue;
      }

      public function get attackers() : Array {
         return this._attackers;
      }

      public function get defenders() : Array {
         return this._defenders;
      }

      public function get reserves() : Array {
         return this._reserves;
      }

      public function get mapId() : int {
         return this._mapId;
      }

      public function get subareaId() : int {
         return this._subareaId;
      }

      public function get worldX() : int {
         return this._worldX;
      }

      public function get worldY() : int {
         return this._worldY;
      }

      public function _pickup_fighter(vec:Array, defenderId:uint) : PrismFightersWrapper {
         var defender:PrismFightersWrapper = null;
         var idx:uint = 0;
         var found:Boolean = false;
         for each (defender in vec)
         {
            if(defender.playerCharactersInformations.id==defenderId)
            {
               found=true;
               break;
            }
            idx++;
         }
         return vec.splice(idx,1)[0];
      }

      public function pushed() : Boolean {
         this._infoJoinLeave=false;
         return true;
      }

      public function process(msg:Message) : Boolean {
         var pfjlract:PrismFightJoinLeaveRequestAction = null;
         var pfjlrmsg:PrismFightJoinLeaveRequestMessage = null;
         var pfsract:PrismFightSwapRequestAction = null;
         var playerGrade:* = 0;
         var otherGrade:* = 0;
         var pfsrmsg:PrismFightSwapRequestMessage = null;
         var pijlract:PrismInfoJoinLeaveRequestAction = null;
         var pijlrmsg:PrismInfoJoinLeaveRequestMessage = null;
         var pwiract:PrismWorldInformationRequestAction = null;
         var pwirmsg:PrismWorldInformationRequestMessage = null;
         var pbract:PrismBalanceRequestAction = null;
         var pbramsg:PrismBalanceRequestMessage = null;
         var pcbract:PrismCurrentBonusRequestAction = null;
         var pcbrmsg:PrismCurrentBonusRequestMessage = null;
         var pbra:PrismAttackRequestAction = null;
         var pbrqmsg:PrismAttackRequestMessage = null;
         var pura:PrismUseRequestAction = null;
         var purmsg:PrismUseRequestMessage = null;
         var pbrmsg:PrismBalanceResultMessage = null;
         var pabrmsg:PrismAlignmentBonusResultMessage = null;
         var pfdsmsg:PrismFightDefendersStateMessage = null;
         var pfdamsg:PrismFightDefenderAddMessage = null;
         var defendersUpdated:* = false;
         var reservesUpdated:* = false;
         var pfdlmsg:PrismFightDefenderLeaveMessage = null;
         var pfdswmsg:PrismFightDefendersSwapMessage = null;
         var reserve:PrismFightersWrapper = null;
         var defender:PrismFightersWrapper = null;
         var pfamsg:PrismFightAttackedMessage = null;
         var subArea:SubArea = null;
         var info:String = null;
         var pfaamsg:PrismFightAttackerAddMessage = null;
         var pfarmsg:PrismFightAttackerRemoveMessage = null;
         var pwimsg:PrismWorldInformationMessage = null;
         var asuemsg:AlignmentSubAreaUpdateExtendedMessage = null;
         var picmsg:PrismInfoCloseMessage = null;
         var pivmsg:PrismInfoValidMessage = null;
         var piivmsg:PrismInfoInValidMessage = null;
         var pfsumsg:PrismFightStateUpdateMessage = null;
         var cmplagi:PrismFightersWrapper = null;
         var def:CharacterMinimalPlusLookAndGradeInformations = null;
         var res:CharacterMinimalPlusLookAndGradeInformations = null;
         var text:String = null;
         var attacker:CharacterMinimalPlusLookAndGradeInformations = null;
         switch(true)
         {
            case msg is PrismFightJoinLeaveRequestAction:
               pfjlract=msg as PrismFightJoinLeaveRequestAction;
               pfjlrmsg=new PrismFightJoinLeaveRequestMessage();
               pfjlrmsg.initPrismFightJoinLeaveRequestMessage(pfjlract.join);
               ConnectionsHandler.getConnection().send(pfjlrmsg);
               return true;
            case msg is PrismFightSwapRequestAction:
               pfsract=msg as PrismFightSwapRequestAction;
               playerGrade=PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade;
               otherGrade=0;
               for each (cmplagi in this._defenders)
               {
                  if(cmplagi.playerCharactersInformations.id==pfsract.targetId)
                  {
                     otherGrade=cmplagi.playerCharactersInformations.grade;
                     break;
                  }
               }
               if(playerGrade<=otherGrade)
               {
                  return true;
               }
               pfsrmsg=new PrismFightSwapRequestMessage();
               pfsrmsg.initPrismFightSwapRequestMessage(pfsract.targetId);
               ConnectionsHandler.getConnection().send(pfsrmsg);
               return true;
            case msg is PrismInfoJoinLeaveRequestAction:
               pijlract=msg as PrismInfoJoinLeaveRequestAction;
               pijlrmsg=new PrismInfoJoinLeaveRequestMessage();
               pijlrmsg.initPrismInfoJoinLeaveRequestMessage(pijlract.join);
               this._infoJoinLeave=pijlract.join;
               if(pijlract.join)
               {
                  this._attackers=new Array();
                  this._reserves=new Array();
                  this._defenders=new Array();
               }
               ConnectionsHandler.getConnection().send(pijlrmsg);
               return true;
            case msg is PrismWorldInformationRequestAction:
               pwiract=msg as PrismWorldInformationRequestAction;
               pwirmsg=new PrismWorldInformationRequestMessage();
               pwirmsg.initPrismWorldInformationRequestMessage(pwiract.join);
               ConnectionsHandler.getConnection().send(pwirmsg);
               return true;
            case msg is PrismBalanceRequestAction:
               pbract=msg as PrismBalanceRequestAction;
               pbramsg=new PrismBalanceRequestMessage();
               pbramsg.initPrismBalanceRequestMessage();
               ConnectionsHandler.getConnection().send(pbramsg);
               return true;
            case msg is PrismCurrentBonusRequestAction:
               pcbract=msg as PrismCurrentBonusRequestAction;
               pcbrmsg=new PrismCurrentBonusRequestMessage();
               pcbrmsg.initPrismCurrentBonusRequestMessage();
               ConnectionsHandler.getConnection().send(pcbrmsg);
               return true;
            case msg is PrismAttackRequestAction:
               pbra=msg as PrismAttackRequestAction;
               pbrqmsg=new PrismAttackRequestMessage();
               pbrqmsg.initPrismAttackRequestMessage();
               ConnectionsHandler.getConnection().send(pbrqmsg);
               return true;
            case msg is PrismUseRequestAction:
               pura=msg as PrismUseRequestAction;
               purmsg=new PrismUseRequestMessage();
               purmsg.initPrismUseRequestMessage();
               ConnectionsHandler.getConnection().send(purmsg);
               return true;
            case msg is PrismBalanceResultMessage:
               pbrmsg=msg as PrismBalanceResultMessage;
               this._totalBalanceValue=pbrmsg.totalBalanceValue;
               this._subAreaBalanceValue=pbrmsg.subAreaBalanceValue;
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismBalance,pbrmsg.subAreaBalanceValue);
               return true;
            case msg is PrismAlignmentBonusResultMessage:
               pabrmsg=msg as PrismAlignmentBonusResultMessage;
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismAlignmentBonus,pabrmsg.alignmentBonus.grademult,pabrmsg.alignmentBonus.pctbonus);
               return true;
            case msg is PrismFightDefendersStateMessage:
               pfdsmsg=msg as PrismFightDefendersStateMessage;
               if(pfdsmsg.fightId!=this._fightId)
               {
                  this._fightId=pfdsmsg.fightId;
               }
               this._defenders=new Array();
               for each (def in pfdsmsg.mainFighters)
               {
                  this._defenders.push(PrismFightersWrapper.create(def));
               }
               this._reserves=new Array();
               for each (res in pfdsmsg.reserveFighters)
               {
                  this._reserves.push(PrismFightersWrapper.create(res));
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate,this._fightId,true,true,true);
               return true;
            case msg is PrismFightDefenderAddMessage:
               pfdamsg=msg as PrismFightDefenderAddMessage;
               defendersUpdated=false;
               reservesUpdated=false;
               if(pfdamsg.fightId!=this._fightId)
               {
               }
               if(pfdamsg.inMain)
               {
                  this._defenders.push(PrismFightersWrapper.create(pfdamsg.fighterMovementInformations));
                  defendersUpdated=true;
               }
               else
               {
                  this._reserves.push(PrismFightersWrapper.create(pfdamsg.fighterMovementInformations));
                  reservesUpdated=true;
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate,this._fightId,false,defendersUpdated,reservesUpdated);
               return true;
            case msg is PrismFightDefenderLeaveMessage:
               pfdlmsg=msg as PrismFightDefenderLeaveMessage;
               if(pfdlmsg.fightId!=this._fightId)
               {
               }
               this._pickup_fighter(this._defenders,pfdlmsg.fighterToRemoveId);
               if(pfdlmsg.successor!=0)
               {
                  this._defenders.push(this._pickup_fighter(this._reserves,pfdlmsg.successor));
               }
               if((!this._infoJoinLeave)&&(pfdlmsg.fighterToRemoveId==PlayedCharacterManager.getInstance().infos.id))
               {
                  text=I18n.getUiText("ui.prism.AutoDisjoin");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate,this._fightId,false,true,!(pfdlmsg.successor==0));
               return true;
            case msg is PrismFightDefendersSwapMessage:
               pfdswmsg=msg as PrismFightDefendersSwapMessage;
               if(pfdswmsg.fightId!=this._fightId)
               {
               }
               reserve=this._pickup_fighter(this._reserves,pfdswmsg.fighterId1);
               defender=this._pickup_fighter(this._defenders,pfdswmsg.fighterId2);
               this._reserves.push(defender);
               this._defenders.push(reserve);
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate,this._fightId,false,true,true);
               return true;
            case msg is PrismFightAttackedMessage:
               pfamsg=msg as PrismFightAttackedMessage;
               this._mapId=pfamsg.mapId;
               this._subareaId=pfamsg.subAreaId;
               this._worldX=pfamsg.worldX;
               this._worldY=pfamsg.worldY;
               subArea=SubArea.getSubAreaById(this._subareaId);
               info=I18n.getUiText("ui.prism.attacked",[subArea.name,"{map,"+this.worldX+","+this.worldY+"}"]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,info,ChatActivableChannelsEnum.CHANNEL_ALIGN,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismAttacked);
               return true;
            case msg is PrismFightAttackerAddMessage:
               pfaamsg=msg as PrismFightAttackerAddMessage;
               if(pfaamsg.fightId!=this._fightId)
               {
               }
               for each (attacker in pfaamsg.charactersDescription)
               {
                  this._attackers.push(PrismFightersWrapper.create(attacker));
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate,this._fightId,true,false,false);
               return true;
            case msg is PrismFightAttackerRemoveMessage:
               pfarmsg=msg as PrismFightAttackerRemoveMessage;
               if(pfarmsg.fightId!=this._fightId)
               {
               }
               this._pickup_fighter(this._attackers,pfarmsg.fighterToRemoveId);
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightUpdate,this._fightId,true,false,false);
               return true;
            case msg is PrismWorldInformationMessage:
               pwimsg=msg as PrismWorldInformationMessage;
               this._nbSubOwned=pwimsg.nbSubOwned;
               this._subTotal=pwimsg.subTotal;
               this._maxSub=pwimsg.maxSub;
               this._subAreasInformation=pwimsg.subAreasInformation;
               this._nbConqsOwned=pwimsg.nbConqsOwned;
               this._conqsTotal=pwimsg.conqsTotal;
               this._conquetesInformation=pwimsg.conquetesInformation;
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismWorldInformation,pwimsg.nbSubOwned,pwimsg.subTotal,pwimsg.maxSub,pwimsg.subAreasInformation,pwimsg.nbConqsOwned,pwimsg.conqsTotal,pwimsg.conquetesInformation);
               return true;
            case msg is AlignmentSubAreaUpdateExtendedMessage:
               asuemsg=msg as AlignmentSubAreaUpdateExtendedMessage;
               if(asuemsg.eventType==SubareaUpdateEventEnum.SUBAREA_EVENT_PRISM_ADDED)
               {
                  KernelEventsManager.getInstance().processCallback(PrismHookList.PrismAdd,asuemsg.mapId,asuemsg.side,asuemsg.worldX,asuemsg.worldY,asuemsg.subAreaId);
               }
               else
               {
                  if(asuemsg.eventType==SubareaUpdateEventEnum.SUBAREA_EVENT_PRISM_REMOVED)
                  {
                     KernelEventsManager.getInstance().processCallback(PrismHookList.PrismRemoved,asuemsg.mapId);
                  }
               }
               return true;
            case msg is PrismInfoCloseMessage:
               picmsg=msg as PrismInfoCloseMessage;
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInfoClose);
               return true;
            case msg is PrismInfoValidMessage:
               pivmsg=msg as PrismInfoValidMessage;
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInfoValid,pivmsg.waitingForHelpInfo.timeLeftBeforeFight,pivmsg.waitingForHelpInfo.waitTimeForPlacement,pivmsg.waitingForHelpInfo.nbPositionForDefensors);
               return true;
            case msg is PrismInfoInValidMessage:
               piivmsg=msg as PrismInfoInValidMessage;
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismInfoInvalid,piivmsg.reason);
               return true;
            case msg is PrismFightStateUpdateMessage:
               pfsumsg=msg as PrismFightStateUpdateMessage;
               this._prismState=pfsumsg.state;
               this._defenders=new Array();
               this._attackers=new Array();
               this._reserves=new Array();
               if(Kernel.getWorker().contains(RoleplayContextFrame))
               {
                  KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightStateUpdate,pfsumsg.state);
               }
               return true;
            default:
               return false;
         }
      }

      public function pulled() : Boolean {
         return true;
      }

      public function pushRoleplay() : void {
         KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightStateUpdate,this._prismState);
      }

      public function pullRoleplay() : void {
         if(this._prismState!=0)
         {
            KernelEventsManager.getInstance().processCallback(PrismHookList.PrismFightStateUpdate,0);
         }
      }

      public function getSubAreasInformation(index:uint) : PrismSubAreaWrapper {
         var prismInfo:PrismSubAreaInformation = this._subAreasInformation[index];
         return PrismSubAreaWrapper.create(prismInfo.subAreaId,prismInfo.alignment,prismInfo.mapId,prismInfo.isInFight,prismInfo.isFightable,true,prismInfo.worldX,prismInfo.worldY);
      }

      public function getConquetesInformation(index:uint) : PrismConquestWrapper {
         var prismInfo:VillageConquestPrismInformation = this._conquetesInformation[index];
         return PrismConquestWrapper.create(prismInfo.areaId,prismInfo.areaAlignment,prismInfo.isEntered,prismInfo.isInRoom);
      }
   }

}