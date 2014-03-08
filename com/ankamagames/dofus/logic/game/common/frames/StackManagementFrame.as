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
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import flash.events.KeyboardEvent;
   import com.ankamagames.dofus.logic.common.actions.AddBehaviorToStackAction;
   import com.ankamagames.dofus.types.enums.StackActionEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.RemoveBehaviorToStackAction;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMessage;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
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
         this._checkPointList = new Vector.<CheckPointEntity>();
         this._ignoredMsg = new Vector.<Message>();
         this._stackOutputMessage = new Vector.<AbstractBehavior>();
         this.initStopMessages();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StackManagementFrame));
      
      private static const LIMIT:int = 100;
      
      private static const KEY_CODE:uint = 16;
      
      private static const BEHAVIOR_LIST:Array = [MoveBehavior,InteractiveElementBehavior,ChangeMapBehavior];
      
      private static const ACTION_MESSAGES:Array = ["InteractiveElementActivationMessage","CellClickMessage","AdjacentMapClickMessage"];
      
      private var _stackInputMessage:Vector.<AbstractBehavior>;
      
      private var _stackOutputMessage:Vector.<AbstractBehavior>;
      
      private var _stopMessages:Vector.<String>;
      
      private var _ignoredMsg:Vector.<Message>;
      
      private var _checkPointList:Vector.<CheckPointEntity>;
      
      private var _currentMode:String;
      
      private var _ignoreAllMessages:Boolean = false;
      
      private var _limitReached:Boolean = false;
      
      private var _keyDown:Boolean = false;
      
      private var _paused:Boolean = false;
      
      private var _waitingMessage:Message;
      
      private function onActivate(param1:Event) : void {
         if(!KeyPoll.getInstance().isDown(KEY_CODE) && (this._keyDown))
         {
            this.onKeyUp(null);
         }
      }
      
      public function onKeyDown(param1:KeyboardEvent) : void {
         var _loc2_:AddBehaviorToStackAction = null;
         if(!this._keyDown && param1.keyCode == KEY_CODE)
         {
            this._keyDown = true;
            this.initStackInputMessages(AbstractBehavior.NORMAL);
            _loc2_ = new AddBehaviorToStackAction();
            _loc2_.behavior = [StackActionEnum.MOVE,StackActionEnum.HARVEST];
            Kernel.getWorker().process(_loc2_);
         }
      }
      
      public function onKeyUp(param1:KeyboardEvent=null) : void {
         var _loc3_:RemoveBehaviorToStackAction = null;
         var _loc2_:uint = param1 == null?KEY_CODE:param1.keyCode;
         if((this._keyDown) && _loc2_ == KEY_CODE)
         {
            this._keyDown = false;
            _loc3_ = new RemoveBehaviorToStackAction();
            _loc3_.behavior = StackActionEnum.REMOVE_ALL;
            Kernel.getWorker().process(_loc3_);
         }
      }
      
      private function getInputMessageAlreadyWatched(param1:Vector.<AbstractBehavior>, param2:Class) : AbstractBehavior {
         var _loc4_:AbstractBehavior = null;
         var _loc3_:String = getQualifiedClassName(param2);
         for each (_loc4_ in param1)
         {
            if(getQualifiedClassName(_loc4_) == _loc3_)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      private function initStackInputMessages(param1:String) : void {
         var _loc3_:Class = null;
         var _loc4_:AbstractBehavior = null;
         var _loc5_:AbstractBehavior = null;
         var _loc2_:Vector.<AbstractBehavior> = new Vector.<AbstractBehavior>();
         if(this._stackInputMessage != null)
         {
            _loc2_ = this._stackInputMessage.concat();
         }
         this._stackInputMessage = new Vector.<AbstractBehavior>();
         for each (_loc3_ in BEHAVIOR_LIST)
         {
            _loc4_ = new _loc3_();
            if(param1 == AbstractBehavior.NORMAL || param1 == AbstractBehavior.ALWAYS && _loc4_.type == AbstractBehavior.ALWAYS)
            {
               _loc5_ = this.getInputMessageAlreadyWatched(_loc2_,_loc3_);
               if(_loc5_ != null)
               {
                  this._stackInputMessage.push(_loc5_);
               }
               else
               {
                  this.addBehaviorToInputStack(_loc4_,true);
               }
            }
            else
            {
               this.addBehaviorToInputStack(_loc4_,false);
            }
         }
         this._currentMode = param1;
      }
      
      private function initStopMessages() : void {
         this._stopMessages = new Vector.<String>();
         this._stopMessages.push("NpcDialogCreationMessage");
         this._stopMessages.push("CurrentMapMessage");
         this._stopMessages.push("GameFightStartingMessage");
         this._stopMessages.push("DocumentReadingBeginMessage");
         this._stopMessages.push("LockableShowCodeDialogMessage");
         this._stopMessages.push("PaddockSellBuyDialogMessage");
         this._stopMessages.push("ExchangeStartedMessage");
         this._stopMessages.push("ExchangeStartOkCraftWithInformationMessage");
         this._stopMessages.push("ExchangeStartOkJobIndexMessage");
         this._stopMessages.push("EmotePlayMessage");
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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:AddBehaviorToStackAction = null;
         var _loc3_:RemoveBehaviorToStackAction = null;
         var _loc4_:AbstractBehavior = null;
         var _loc5_:String = null;
         var _loc6_:* = false;
         var _loc7_:* = false;
         var _loc8_:* = false;
         var _loc9_:String = null;
         var _loc10_:AbstractBehavior = null;
         var _loc11_:MoveBehavior = null;
         var _loc12_:ChangeMapBehavior = null;
         var _loc13_:InteractiveElementBehavior = null;
         var _loc14_:* = 0;
         var _loc15_:InteractiveElementActivationMessage = null;
         var _loc16_:* = false;
         switch(true)
         {
            case param1 is AddBehaviorToStackAction:
               _loc2_ = param1 as AddBehaviorToStackAction;
               for each (_loc19_ in _loc2_.behavior)
               {
                  switch(_loc9_)
                  {
                     case StackActionEnum.MOVE:
                        this.addBehaviorToInputStack(new MoveBehavior());
                        this.addBehaviorToInputStack(new ChangeMapBehavior());
                        continue;
                     case StackActionEnum.HARVEST:
                        this.addBehaviorToInputStack(new InteractiveElementBehavior());
                        continue;
                     default:
                        continue;
                  }
               }
               return true;
            case param1 is RemoveBehaviorToStackAction:
               _loc3_ = param1 as RemoveBehaviorToStackAction;
               switch(_loc3_.behavior)
               {
                  case StackActionEnum.REMOVE_ALL:
                     this.stopWatchingActions();
                     break;
               }
               return true;
            case param1 is EmptyStackAction:
               this.emptyStack();
               return true;
            default:
               _loc5_ = getQualifiedClassName(param1).split("::")[1];
               _loc6_ = _loc5_ == "InteractiveUsedMessage" || _loc5_ == "InteractiveUseErrorMessage";
               if((this._paused) && (!(ACTION_MESSAGES.indexOf(_loc5_) == -1) || (_loc6_)))
               {
                  for each (_loc10_ in this._stackOutputMessage)
                  {
                     switch(true)
                     {
                        case _loc10_ is MoveBehavior:
                           _loc11_ = _loc10_ as MoveBehavior;
                           if(param1 is CellClickMessage && (param1 as CellClickMessage).cellId == _loc11_.getMapPoint().cellId)
                           {
                              this._waitingMessage = param1;
                              return false;
                           }
                           continue;
                        case _loc10_ is ChangeMapBehavior:
                           _loc12_ = _loc10_ as ChangeMapBehavior;
                           if(param1 is AdjacentMapClickMessage && (param1 as AdjacentMapClickMessage).cellId == _loc12_.getMapPoint().cellId)
                           {
                              this._waitingMessage = param1;
                              return false;
                           }
                           continue;
                        case _loc10_ is InteractiveElementBehavior:
                           _loc13_ = _loc10_ as InteractiveElementBehavior;
                           if(param1 is InteractiveElementActivationMessage && (param1 as InteractiveElementActivationMessage).interactiveElement.elementId == _loc13_.interactiveElement.elementId)
                           {
                              this._waitingMessage = param1;
                              return false;
                           }
                           if((_loc6_) && _loc13_.interactiveElement.elementId == (param1 as Object).elemId)
                           {
                              _loc13_.processOutputMessage(param1,this._currentMode);
                              this.removeCheckPoint(_loc13_);
                              _loc14_ = this._stackOutputMessage.indexOf(_loc13_);
                              _loc15_ = this._waitingMessage as InteractiveElementActivationMessage;
                              if((_loc15_) && _loc15_.interactiveElement.elementId == _loc13_.interactiveElement.elementId)
                              {
                                 this._waitingMessage = null;
                              }
                              if(_loc14_ != -1)
                              {
                                 this._stackOutputMessage.splice(_loc14_,1);
                                 return false;
                              }
                           }
                           continue;
                        default:
                           continue;
                     }
                  }
                  return false;
               }
               for each (_loc4_ in this._stackInputMessage)
               {
                  _loc4_.checkAvailability(param1);
               }
               if(this._stopMessages.indexOf(_loc5_) != -1)
               {
                  _loc16_ = true;
                  if(param1 is EmotePlayMessage)
                  {
                     if((param1 as EmotePlayMessage).actorId != PlayedCharacterManager.getInstance().id)
                     {
                        _loc16_ = false;
                     }
                  }
                  if(_loc16_)
                  {
                     this.emptyStack();
                     return false;
                  }
               }
               if(this._ignoredMsg.indexOf(param1) != -1)
               {
                  this._ignoredMsg.splice(this._ignoredMsg.indexOf(param1),1);
                  return false;
               }
               _loc7_ = this.processStackInputMessages(param1);
               _loc8_ = this.processStackOutputMessages(param1);
               return _loc7_;
         }
      }
      
      private function processStackInputMessages(param1:Message) : Boolean {
         var _loc2_:AbstractBehavior = null;
         var _loc3_:AbstractBehavior = null;
         var _loc4_:AbstractBehavior = null;
         var _loc5_:CheckPointEntity = null;
         var _loc6_:String = null;
         if(this._stackOutputMessage.length >= LIMIT)
         {
            this._limitReached = true;
         }
         for each (_loc2_ in this._stackInputMessage)
         {
            if(_loc2_.processInputMessage(param1,this._currentMode))
            {
               if(this._currentMode == AbstractBehavior.ALWAYS && (!_loc2_.isActive || this._stackOutputMessage.length > 0 && !_loc2_.isAvailableToStart))
               {
                  this.emptyStack(false);
                  if(!_loc2_.isActive)
                  {
                     return false;
                  }
               }
               if(_loc2_.canBeStacked)
               {
                  _loc3_ = _loc2_.copy();
                  _loc4_ = this.getSameInOutputList(_loc3_);
                  if(_loc4_ == null)
                  {
                     if((this._ignoreAllMessages) || (this._limitReached))
                     {
                        _loc6_ = "";
                        if(this._ignoreAllMessages)
                        {
                           _loc6_ = I18n.getUiText("ui.stack.stop");
                        }
                        else
                        {
                           if(this._limitReached)
                           {
                              _loc6_ = I18n.getUiText("ui.stack.limit",[LIMIT]);
                           }
                        }
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc6_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
                        return true;
                     }
                     if(this._stackOutputMessage.length == 0 && (_loc2_.needToWait) && this._currentMode == AbstractBehavior.NORMAL)
                     {
                        this._stackOutputMessage.push(AbstractBehavior.createFake(StackActionEnum.MOVE,[_loc2_.getFakePosition()]));
                     }
                     this._stackOutputMessage.push(_loc3_);
                     if(!(this._currentMode == AbstractBehavior.ALWAYS) || this._currentMode == AbstractBehavior.ALWAYS && this._stackOutputMessage.length > 1)
                     {
                        _loc3_.addIcon();
                     }
                     _loc5_ = new CheckPointEntity(_loc3_.sprite,_loc2_.getMapPoint());
                     this._checkPointList.push(_loc5_);
                     EntitiesDisplayManager.getInstance().displayEntity(_loc5_,_loc2_.getMapPoint(),PlacementStrataEnums.STRATA_AREA);
                     if(_loc2_.type == AbstractBehavior.STOP)
                     {
                        this._ignoreAllMessages = true;
                     }
                  }
                  else
                  {
                     if(_loc4_.type == AbstractBehavior.STOP)
                     {
                        this._ignoreAllMessages = false;
                     }
                     this.removeCheckPoint(_loc4_);
                     this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(_loc4_),1);
                     if((this._limitReached) && this._stackOutputMessage.length < LIMIT)
                     {
                        this._limitReached = false;
                     }
                  }
                  _loc2_.reset();
                  return true;
               }
            }
         }
         return false;
      }
      
      private function getSameInOutputList(param1:AbstractBehavior) : AbstractBehavior {
         var _loc2_:AbstractBehavior = null;
         for each (_loc2_ in this._stackOutputMessage)
         {
            if((_loc2_.getMapPoint()) && _loc2_.getMapPoint().cellId == param1.getMapPoint().cellId)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function processStackOutputMessages(param1:Message) : Boolean {
         var _loc2_:AbstractBehavior = null;
         var _loc3_:* = false;
         if(this._stackOutputMessage.length > 0)
         {
            _loc2_ = this._stackOutputMessage[0];
            if(_loc2_.pendingMessage == null)
            {
               _loc3_ = _loc2_.processOutputMessage(param1,this._currentMode);
               if(_loc3_)
               {
                  this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(_loc2_),1);
                  if((this._limitReached) && this._stackOutputMessage.length < LIMIT)
                  {
                     this._limitReached = false;
                  }
                  if((this._ignoreAllMessages) && _loc2_.type == AbstractBehavior.STOP)
                  {
                     this._ignoreAllMessages = false;
                  }
               }
               if(_loc2_.actionStarted)
               {
                  this.removeCheckPoint(_loc2_);
               }
            }
            else
            {
               if(_loc2_.pendingMessage != null)
               {
                  while(this._stackOutputMessage.length > 0)
                  {
                     _loc2_ = this._stackOutputMessage[0];
                     if(_loc2_.isAvailableToProcess(param1))
                     {
                        this._ignoredMsg.push(_loc2_.pendingMessage);
                        _loc2_.processMessageToWorker();
                        break;
                     }
                     this.removeCheckPoint(_loc2_);
                     this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(_loc2_),1);
                     if((this._limitReached) && this._stackOutputMessage.length < LIMIT)
                     {
                        this._limitReached = false;
                     }
                  }
               }
            }
            return _loc2_.isMessageCatchable(param1);
         }
         return false;
      }
      
      private function removeCheckPoint(param1:AbstractBehavior) : void {
         var _loc2_:CheckPointEntity = null;
         param1.removeIcon();
         if(this._checkPointList.length > 0)
         {
            for each (_loc2_ in this._checkPointList)
            {
               if((param1.getMapPoint()) && param1.getMapPoint().cellId == _loc2_.position.cellId)
               {
                  EntitiesDisplayManager.getInstance().removeEntity(_loc2_);
                  this._checkPointList.splice(this._checkPointList.indexOf(_loc2_),1);
                  return;
               }
            }
         }
      }
      
      private function emptyStack(param1:Boolean=true) : void {
         var _loc2_:AbstractBehavior = null;
         var _loc4_:CheckPointEntity = null;
         if(this._stackOutputMessage.length == 1 && this._stackOutputMessage[0].actionStarted == false)
         {
            this._stackOutputMessage[0].removeIcon();
            this._stackOutputMessage[0].remove();
            this._stackOutputMessage = new Vector.<AbstractBehavior>();
         }
         var _loc3_:Vector.<AbstractBehavior> = this._stackOutputMessage.concat();
         for each (_loc2_ in _loc3_)
         {
            if((param1) || !(_loc3_.indexOf(_loc2_) == 0) || _loc3_.indexOf(_loc2_) == 0 && !_loc2_.actionStarted)
            {
               _loc2_.removeIcon();
               _loc2_.remove();
               this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(_loc2_),1);
            }
         }
         _loc3_ = null;
         for each (_loc4_ in this._checkPointList)
         {
            EntitiesDisplayManager.getInstance().removeEntity(_loc4_);
         }
         this.initStackInputMessages(this._currentMode);
         this._checkPointList = new Vector.<CheckPointEntity>();
         this._ignoredMsg = new Vector.<Message>();
         this._ignoreAllMessages = false;
         this._limitReached = false;
      }
      
      private function stopWatchingActions() : void {
         this.initStackInputMessages(AbstractBehavior.ALWAYS);
      }
      
      private function addBehaviorToInputStack(param1:AbstractBehavior, param2:Boolean=true) : void {
         var _loc4_:String = null;
         var _loc5_:AbstractBehavior = null;
         var _loc3_:String = getQualifiedClassName(param1);
         for each (_loc5_ in this._stackInputMessage)
         {
            _loc4_ = getQualifiedClassName(_loc5_);
            if(_loc3_ == _loc4_)
            {
               _loc5_.isActive = param2;
               return;
            }
         }
         param1.isActive = param2;
         this._stackInputMessage.push(param1);
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
      
      public function get waitingMessage() : Message {
         return this._waitingMessage;
      }
      
      public function set waitingMessage(param1:Message) : void {
         this._waitingMessage = param1;
      }
      
      public function get paused() : Boolean {
         return this._paused;
      }
      
      public function set paused(param1:Boolean) : void {
         this._paused = param1;
      }
   }
}
