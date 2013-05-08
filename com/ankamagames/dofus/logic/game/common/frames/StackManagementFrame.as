package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.MoveBehavior;
   import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.InteractiveElementBehavior;
   import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.ChangeMapBehavior;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.AbstractBehavior;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.types.entities.CheckPointEntity;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import flash.events.KeyboardEvent;
   import com.ankamagames.dofus.logic.common.actions.AddBehaviorToStackAction;
   import com.ankamagames.dofus.types.enums.StackActionEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.RemoveBehaviorToStackAction;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.dofus.logic.common.actions.EmptyStackAction;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.jerakine.types.enums.Priority;


   public class StackManagementFrame extends Object implements Frame
   {
         

      public function StackManagementFrame() {
         super();
         this.initStackInputMessages(AbstractBehavior.ALWAYS);
         this._checkPointList=new Vector.<CheckPointEntity>();
         this._ignoredMsg=new Vector.<Message>();
         this._stackOutputMessage=new Vector.<AbstractBehavior>();
         this.initStopMessages();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StackManagementFrame));

      private static const LIMIT:int = 100;

      private static const KEY_CODE:uint = 16;

      private static const BEHAVIOR_LIST:Array = [MoveBehavior,InteractiveElementBehavior,ChangeMapBehavior];

      private var _stackInputMessage:Vector.<AbstractBehavior>;

      private var _stackOutputMessage:Vector.<AbstractBehavior>;

      private var _stopMessages:Vector.<String>;

      private var _ignoredMsg:Vector.<Message>;

      private var _checkPointList:Vector.<CheckPointEntity>;

      private var _currentMode:String;

      private var _ignoreAllMessages:Boolean = false;

      private var _limitReached:Boolean = false;

      private var _roleplayContextFrame:RoleplayContextFrame;

      private var _keyDown:Boolean = false;

      private function onActivate(pEvt:Event) : void {
         if((!KeyPoll.getInstance().isDown(KEY_CODE))&&(this._keyDown))
         {
            this.onKeyUp(null);
         }
      }

      public function onKeyDown(pEvt:KeyboardEvent) : void {
         var m:AddBehaviorToStackAction = null;
         if((!this._keyDown)&&(pEvt.keyCode==KEY_CODE))
         {
            this._keyDown=true;
            this.initStackInputMessages(AbstractBehavior.NORMAL);
            m=new AddBehaviorToStackAction();
            m.behavior=[StackActionEnum.MOVE,StackActionEnum.HARVEST];
            Kernel.getWorker().process(m);
         }
      }

      public function onKeyUp(pEvt:KeyboardEvent=null) : void {
         var m:RemoveBehaviorToStackAction = null;
         var keyCode:uint = pEvt==null?KEY_CODE:pEvt.keyCode;
         if((this._keyDown)&&(keyCode==KEY_CODE))
         {
            this._keyDown=false;
            m=new RemoveBehaviorToStackAction();
            m.behavior=StackActionEnum.REMOVE_ALL;
            Kernel.getWorker().process(m);
         }
      }

      private function getInputMessageAlreadyWatched(vector:Vector.<AbstractBehavior>, inpt:Class) : AbstractBehavior {
         var oldInput:AbstractBehavior = null;
         var behaviorStr:String = getQualifiedClassName(inpt);
         for each (oldInput in vector)
         {
            if(getQualifiedClassName(oldInput)==behaviorStr)
            {
               return oldInput;
            }
         }
         return null;
      }

      private function initStackInputMessages(newMode:String) : void {
         var c:Class = null;
         var b:AbstractBehavior = null;
         var tmp:AbstractBehavior = null;
         var tmpVector:Vector.<AbstractBehavior> = new Vector.<AbstractBehavior>();
         if(this._stackInputMessage!=null)
         {
            tmpVector=this._stackInputMessage.concat();
         }
         this._stackInputMessage=new Vector.<AbstractBehavior>();
         for each (c in BEHAVIOR_LIST)
         {
            b=new c();
            if((newMode==AbstractBehavior.NORMAL)||(newMode==AbstractBehavior.ALWAYS)&&(b.type==AbstractBehavior.ALWAYS))
            {
               tmp=this.getInputMessageAlreadyWatched(tmpVector,c);
               if(tmp!=null)
               {
                  this._stackInputMessage.push(tmp);
               }
               else
               {
                  this.addBehaviorToInputStack(b,true);
               }
            }
            else
            {
               this.addBehaviorToInputStack(b,false);
            }
         }
         this._currentMode=newMode;
      }

      private function initStopMessages() : void {
         this._stopMessages=new Vector.<String>();
         this._stopMessages.push("NpcDialogCreationMessage");
         this._stopMessages.push("CurrentMapMessage");
         this._stopMessages.push("GameFightStartingMessage");
         this._stopMessages.push("DocumentReadingBeginMessage");
         this._stopMessages.push("LockableShowCodeDialogMessage");
         this._stopMessages.push("PaddockSellBuyDialogMessage");
         this._stopMessages.push("ExchangeStartedMessage");
         this._stopMessages.push("ExchangeStartOkCraftWithInformationMessage");
         this._stopMessages.push("ExchangeStartOkJobIndexMessage");
         this._stopMessages.push("GameMapNoMovementMessage");
      }

      public function pushed() : Boolean {
         StageShareManager.stage.addEventListener(Event.ACTIVATE,this.onActivate);
         StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         return true;
      }

      public function pulled() : Boolean {
         StageShareManager.stage.removeEventListener(Event.ACTIVATE,this.onActivate);
         StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         return true;
      }

      public function process(msg:Message) : Boolean {
         var abtsmsg:AddBehaviorToStackAction = null;
         var rbtsmsg:RemoveBehaviorToStackAction = null;
         var currentStopMessage:String = null;
         var catchInputMsg:* = false;
         var catchOutputMsg:* = false;
         var b:String = null;
         var elem:AbstractBehavior = null;
         if(this._roleplayContextFrame==null)
         {
            this._roleplayContextFrame=Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         }
         switch(true)
         {
            case msg is AddBehaviorToStackAction:
               abtsmsg=msg as AddBehaviorToStackAction;
               for each (_loc11_ in abtsmsg.behavior)
               {
                  switch(b)
                  {
                     case StackActionEnum.MOVE:
                        this.addBehaviorToInputStack(new MoveBehavior());
                        this.addBehaviorToInputStack(new ChangeMapBehavior());
                        break;
                     case StackActionEnum.HARVEST:
                        this.addBehaviorToInputStack(new InteractiveElementBehavior());
                        break;
                  }
               }
               return true;
            case msg is RemoveBehaviorToStackAction:
               rbtsmsg=msg as RemoveBehaviorToStackAction;
               switch(rbtsmsg.behavior)
               {
                  case StackActionEnum.REMOVE_ALL:
                     this.stopWatchingActions();
                     break;
               }
               return true;
            case msg is EmptyStackAction:
               this.emptyStack();
               return true;
            default:
               for each (elem in this._stackInputMessage)
               {
                  elem.checkAvailability(msg);
               }
               currentStopMessage=getQualifiedClassName(msg).split("::")[1];
               if(this._stopMessages.indexOf(currentStopMessage)!=-1)
               {
                  _log.error("Just catched a stop message: "+currentStopMessage);
                  this.emptyStack();
                  return false;
               }
               if(this._ignoredMsg.indexOf(msg)!=-1)
               {
                  this._ignoredMsg.splice(this._ignoredMsg.indexOf(msg),1);
                  return false;
               }
               catchInputMsg=this.processStackInputMessages(msg);
               catchOutputMsg=this.processStackOutputMessages(msg);
               return catchInputMsg;
         }
      }

      private function processStackInputMessages(pMsg:Message) : Boolean {
         var elem:AbstractBehavior = null;
         var copy:AbstractBehavior = null;
         var elementInStack:AbstractBehavior = null;
         var ch:CheckPointEntity = null;
         var tchatMessage:String = null;
         if((this._roleplayContextFrame)&&(!this._roleplayContextFrame.hasWorldInteraction))
         {
            this.emptyStack();
            return false;
         }
         if(this._stackOutputMessage.length>=LIMIT)
         {
            this._limitReached=true;
         }
         for each (elem in this._stackInputMessage)
         {
            if(elem.processInputMessage(pMsg,this._currentMode))
            {
               if((this._currentMode==AbstractBehavior.ALWAYS)&&((!elem.isActive)||(this._stackOutputMessage.length<0)&&(!elem.isAvailableToStart)))
               {
                  this.emptyStack(false);
                  if(!elem.isActive)
                  {
                     return false;
                  }
               }
               if(elem.canBeStacked)
               {
                  copy=elem.copy();
                  elementInStack=this.getSameInOutputList(copy);
                  if(elementInStack==null)
                  {
                     if((this._ignoreAllMessages)||(this._limitReached))
                     {
                        tchatMessage="";
                        if(this._ignoreAllMessages)
                        {
                           tchatMessage=I18n.getUiText("ui.stack.stop");
                        }
                        else
                        {
                           if(this._limitReached)
                           {
                              tchatMessage=I18n.getUiText("ui.stack.limit",[LIMIT]);
                           }
                        }
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,tchatMessage,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
                        return true;
                     }
                     if((this._stackOutputMessage.length==0)&&(elem.needToWait)&&(this._currentMode==AbstractBehavior.NORMAL))
                     {
                        this._stackOutputMessage.push(AbstractBehavior.createFake(StackActionEnum.MOVE,[elem.getFakePosition()]));
                     }
                     this._stackOutputMessage.push(copy);
                     if((!(this._currentMode==AbstractBehavior.ALWAYS))||(this._currentMode==AbstractBehavior.ALWAYS)&&(this._stackOutputMessage.length<1))
                     {
                        copy.addIcon();
                     }
                     ch=new CheckPointEntity(copy.sprite,elem.getMapPoint());
                     this._checkPointList.push(ch);
                     EntitiesDisplayManager.getInstance().displayEntity(ch,elem.getMapPoint(),PlacementStrataEnums.STRATA_AREA);
                     if(elem.type==AbstractBehavior.STOP)
                     {
                        this._ignoreAllMessages=true;
                     }
                  }
                  else
                  {
                     if(elementInStack.type==AbstractBehavior.STOP)
                     {
                        this._ignoreAllMessages=false;
                     }
                     this.removeCheckPoint(elementInStack);
                     this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(elementInStack),1);
                     if((this._limitReached)&&(this._stackOutputMessage.length>LIMIT))
                     {
                        this._limitReached=false;
                     }
                  }
                  elem.reset();
                  return true;
               }
            }
         }
         return false;
      }

      private function getSameInOutputList(copy:AbstractBehavior) : AbstractBehavior {
         var be:AbstractBehavior = null;
         for each (be in this._stackOutputMessage)
         {
            if((be.getMapPoint())&&(be.getMapPoint().cellId==copy.getMapPoint().cellId))
            {
               return be;
            }
         }
         return null;
      }

      private function processStackOutputMessages(pMsg:Message) : Boolean {
         var currentStackElement:AbstractBehavior = null;
         var isCatched:* = false;
         if(this._stackOutputMessage.length>0)
         {
            currentStackElement=this._stackOutputMessage[0];
            if(currentStackElement.pendingMessage==null)
            {
               isCatched=currentStackElement.processOutputMessage(pMsg,this._currentMode);
               if(isCatched)
               {
                  this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(currentStackElement),1);
                  if((this._limitReached)&&(this._stackOutputMessage.length>LIMIT))
                  {
                     this._limitReached=false;
                  }
                  if((this._ignoreAllMessages)&&(currentStackElement.type==AbstractBehavior.STOP))
                  {
                     this._ignoreAllMessages=false;
                  }
               }
               if(currentStackElement.actionStarted)
               {
                  this.removeCheckPoint(currentStackElement);
               }
            }
            else
            {
               if(currentStackElement.pendingMessage!=null)
               {
                  while(this._stackOutputMessage.length>0)
                  {
                     currentStackElement=this._stackOutputMessage[0];
                     if(currentStackElement.isAvailableToProcess(pMsg))
                     {
                        this._ignoredMsg.push(currentStackElement.pendingMessage);
                        currentStackElement.processMessageToWorker();
                     }
                     else
                     {
                        this.removeCheckPoint(currentStackElement);
                        this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(currentStackElement),1);
                        if((this._limitReached)&&(this._stackOutputMessage.length>LIMIT))
                        {
                           this._limitReached=false;
                        }
                        continue;
                     }
                  }
               }
            }
            return currentStackElement.isMessageCatchable(pMsg);
         }
         return false;
      }

      private function removeCheckPoint(stackElement:AbstractBehavior) : void {
         var ch:CheckPointEntity = null;
         stackElement.removeIcon();
         if(this._checkPointList.length>0)
         {
            for each (ch in this._checkPointList)
            {
               if((stackElement.getMapPoint())&&(stackElement.getMapPoint().cellId==ch.position.cellId))
               {
                  EntitiesDisplayManager.getInstance().removeEntity(ch);
                  this._checkPointList.splice(this._checkPointList.indexOf(ch),1);
                  return;
               }
            }
         }
      }

      private function emptyStack(all:Boolean=true) : void {
         var outputMessage:AbstractBehavior = null;
         var checkpoint:CheckPointEntity = null;
         if((this._stackOutputMessage.length==1)&&(this._stackOutputMessage[0].actionStarted==false))
         {
            this._stackOutputMessage[0].removeIcon();
            this._stackOutputMessage[0].remove();
            this._stackOutputMessage=new Vector.<AbstractBehavior>();
         }
         var cpy:Vector.<AbstractBehavior> = this._stackOutputMessage.concat();
         for each (outputMessage in cpy)
         {
            if((all)||(!(cpy.indexOf(outputMessage)==0))||(cpy.indexOf(outputMessage)==0)&&(!outputMessage.actionStarted))
            {
               outputMessage.removeIcon();
               outputMessage.remove();
               this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(outputMessage),1);
            }
         }
         cpy=null;
         for each (checkpoint in this._checkPointList)
         {
            EntitiesDisplayManager.getInstance().removeEntity(checkpoint);
         }
         this.initStackInputMessages(this._currentMode);
         this._checkPointList=new Vector.<CheckPointEntity>();
         this._ignoredMsg=new Vector.<Message>();
         this._ignoreAllMessages=false;
         this._limitReached=false;
      }

      private function stopWatchingActions() : void {
         this.initStackInputMessages(AbstractBehavior.ALWAYS);
      }

      private function addBehaviorToInputStack(behavior:AbstractBehavior, pIsActive:Boolean=true) : void {
         var typeOfOtherBehavior:String = null;
         var b:AbstractBehavior = null;
         var typeOfNewBehavior:String = getQualifiedClassName(behavior);
         for each (b in this._stackInputMessage)
         {
            typeOfOtherBehavior=getQualifiedClassName(b);
            if(typeOfNewBehavior==typeOfOtherBehavior)
            {
               b.isActive=pIsActive;
               return;
            }
         }
         behavior.isActive=pIsActive;
         this._stackInputMessage.push(behavior);
      }

      public function get priority() : int {
         return Priority.HIGHEST;
      }

      public function get stackInputMessage() : Vector.<AbstractBehavior> {
         return this._stackInputMessage;
      }

      public function get stackOutputMessage() : Vector.<AbstractBehavior> {
         return this._stackOutputMessage;
      }

      public function get roleplayContextFrame() : RoleplayContextFrame {
         return this._roleplayContextFrame;
      }

      public function set roleplayContextFrame(val:RoleplayContextFrame) : void {
         this._roleplayContextFrame=val;
      }
   }

}