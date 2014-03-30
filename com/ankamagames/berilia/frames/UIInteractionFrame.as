package com.ankamagames.berilia.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.FocusChangeMessage;
   import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.messages.ComponentMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.berilia.types.event.InstanceEvent;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMiddleClickMessage;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.managers.UiSoundManager;
   import com.ankamagames.berilia.enums.EventEnums;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.pools.GenericPool;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.components.messages.SelectEmptyItemMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOverMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOutMessage;
   import com.ankamagames.berilia.components.messages.ItemRightClickMessage;
   import com.ankamagames.berilia.components.messages.DropMessage;
   import com.ankamagames.berilia.components.messages.DeleteTabMessage;
   import com.ankamagames.berilia.components.messages.RenameTabMessage;
   import com.ankamagames.berilia.api.ReadOnlyObject;
   import com.ankamagames.berilia.components.messages.MapElementRollOverMessage;
   import com.ankamagames.berilia.components.messages.MapElementRollOutMessage;
   import com.ankamagames.berilia.components.messages.MapElementRightClickMessage;
   import com.ankamagames.berilia.components.messages.MapRollOverMessage;
   import com.ankamagames.berilia.components.messages.VideoBufferChangeMessage;
   import com.ankamagames.berilia.components.messages.TextClickMessage;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import com.ankamagames.berilia.components.messages.BrowserSessionTimeout;
   import com.ankamagames.berilia.components.messages.BrowserDomReady;
   import com.ankamagames.berilia.components.messages.ColorChangeMessage;
   import com.ankamagames.berilia.components.messages.EntityReadyMessage;
   import com.ankamagames.berilia.components.messages.TextureReadyMessage;
   import com.ankamagames.berilia.components.messages.TextureLoadFailMessage;
   import com.ankamagames.berilia.components.messages.CreateTabMessage;
   import com.ankamagames.berilia.components.messages.MapMoveMessage;
   import com.ankamagames.berilia.components.messages.VideoConnectFailedMessage;
   import com.ankamagames.berilia.components.messages.VideoConnectSuccessMessage;
   import com.ankamagames.berilia.components.messages.ComponentReadyMessage;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class UIInteractionFrame extends Object implements Frame
   {
      
      public function UIInteractionFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UIInteractionFrame));
      
      public function get priority() : int {
         return Priority.HIGHEST;
      }
      
      private var hierarchy:Array;
      
      private var currentDo:DisplayObject;
      
      private var _isProcessingDirectInteraction:Boolean;
      
      public function get isProcessingDirectInteraction() : Boolean {
         return this._isProcessingDirectInteraction;
      }
      
      public function process(msg:Message) : Boolean {
         var fcmsg:FocusChangeMessage = null;
         var himsg:HumanInputMessage = null;
         var onlyGrid:* = false;
         var isGrid:* = false;
         var gridInstance:Grid = null;
         var dispatched:* = false;
         var comsg:ComponentMessage = null;
         var kkumsg:KeyboardKeyUpMessage = null;
         var uic:UIComponent = null;
         var res:* = false;
         var newMsg:MouseClickMessage = null;
         var uic3:UIComponent = null;
         var uic4:UIComponent = null;
         var act2:Action = null;
         var targetFct:String = null;
         var ie2:InstanceEvent = null;
         var args:Array = null;
         this._isProcessingDirectInteraction = false;
         this.currentDo = null;
         switch(true)
         {
            case msg is FocusChangeMessage:
               fcmsg = FocusChangeMessage(msg);
               this.hierarchy = new Array();
               this.currentDo = fcmsg.target;
               while(this.currentDo != null)
               {
                  if(this.currentDo is UIComponent)
                  {
                     this.hierarchy.unshift(this.currentDo);
                  }
                  this.currentDo = this.currentDo.parent;
               }
               if(this.hierarchy.length > 0)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.FocusChange,SecureCenter.secure(this.hierarchy[this.hierarchy.length - 1]));
               }
               return true;
            case msg is HumanInputMessage:
               this._isProcessingDirectInteraction = true;
               himsg = HumanInputMessage(msg);
               this.hierarchy = new Array();
               this.currentDo = himsg.target;
               while(this.currentDo != null)
               {
                  if(this.currentDo is UIComponent)
                  {
                     this.hierarchy.push(this.currentDo);
                  }
                  this.currentDo = this.currentDo.parent;
               }
               if(msg is MouseClickMessage)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseClick,SecureCenter.secure(MouseClickMessage(msg).target));
               }
               if(msg is MouseMiddleClickMessage)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseMiddleClick,SecureCenter.secure(MouseMiddleClickMessage(msg).target));
               }
               if(msg is KeyboardKeyUpMessage)
               {
                  kkumsg = KeyboardKeyUpMessage(msg);
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyUp,SecureCenter.secure(kkumsg.target),kkumsg.keyboardEvent.keyCode);
               }
               onlyGrid = false;
               dispatched = false;
               for each (uic in this.hierarchy)
               {
                  isGrid = UIComponent(uic) is Grid;
                  if((!onlyGrid) || (isGrid))
                  {
                     res = UIComponent(uic).process(himsg);
                     if(res)
                     {
                        if((isGrid) && (!himsg.canceled))
                        {
                           dispatched = true;
                           onlyGrid = true;
                        }
                        else
                        {
                           this.hierarchy = null;
                           this.currentDo = null;
                           this._isProcessingDirectInteraction = false;
                           return true;
                        }
                     }
                  }
                  if((!gridInstance) && (isGrid))
                  {
                     gridInstance = Grid(uic);
                  }
               }
               this.currentDo = himsg.target;
               while(this.currentDo != null)
               {
                  if(this.currentDo is GraphicContainer)
                  {
                     UiSoundManager.getInstance().fromUiElement(this.currentDo as GraphicContainer,EventEnums.convertMsgToFct(getQualifiedClassName(msg)));
                  }
                  if(UIEventManager.getInstance().isRegisteredInstance(this.currentDo,msg))
                  {
                     dispatched = true;
                     this.processRegisteredUiEvent(msg,gridInstance);
                     break;
                  }
                  this.currentDo = this.currentDo.parent;
               }
               if(msg is MouseClickMessage)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.PostMouseClick,SecureCenter.secure(MouseClickMessage(msg).target));
               }
               if((msg is MouseDoubleClickMessage) && (!dispatched))
               {
                  newMsg = GenericPool.get(MouseClickMessage,himsg.target as InteractiveObject,new MouseEvent(MouseEvent.CLICK));
                  Berilia.getInstance().handler.process(newMsg);
               }
               this.hierarchy = null;
               this.currentDo = null;
               this._isProcessingDirectInteraction = false;
               break;
            case msg is ComponentMessage:
               comsg = ComponentMessage(msg);
               this.hierarchy = new Array();
               this.currentDo = comsg.target;
               while(this.currentDo != null)
               {
                  if(this.currentDo is UIComponent)
                  {
                     this.hierarchy.unshift(this.currentDo);
                  }
                  this.currentDo = this.currentDo.parent;
               }
               if(this.hierarchy.length == 0)
               {
                  this._isProcessingDirectInteraction = false;
                  return false;
               }
               for each (uic3 in this.hierarchy)
               {
                  UIComponent(uic3).process(comsg);
               }
               comsg.bubbling = true;
               this.hierarchy.reverse();
               this.hierarchy.pop();
               for each (uic4 in this.hierarchy)
               {
                  UIComponent(uic4).process(comsg);
               }
               this.hierarchy = null;
               if(!comsg.canceled)
               {
                  for each (act2 in comsg.actions)
                  {
                     Berilia.getInstance().handler.process(act2);
                  }
                  targetFct = EventEnums.convertMsgToFct(getQualifiedClassName(msg));
                  UiSoundManager.getInstance().fromUiElement(comsg.target as GraphicContainer,targetFct);
                  this.currentDo = comsg.target;
                  while(this.currentDo != null)
                  {
                     if((UIEventManager.getInstance().instances[this.currentDo]) && (UIEventManager.getInstance().instances[this.currentDo].events[getQualifiedClassName(msg)]))
                     {
                        ie2 = InstanceEvent(UIEventManager.getInstance().instances[this.currentDo]);
                        switch(true)
                        {
                           case msg is MouseMiddleClickMessage:
                           case msg is ChangeMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is BrowserSessionTimeout:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is BrowserDomReady:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is ColorChangeMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is EntityReadyMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is SelectItemMessage:
                              if((!(SelectItemMessage(msg).selectMethod == SelectMethodEnum.MANUAL)) && (!(SelectItemMessage(msg).selectMethod == SelectMethodEnum.AUTO)))
                              {
                                 this._isProcessingDirectInteraction = true;
                              }
                              args = [SecureCenter.secure(ie2.instance),SelectItemMessage(msg).selectMethod,SelectItemMessage(msg).isNewSelection];
                              break;
                           case msg is SelectEmptyItemMessage:
                              if((!(SelectEmptyItemMessage(msg).selectMethod == SelectMethodEnum.MANUAL)) && (!(SelectEmptyItemMessage(msg).selectMethod == SelectMethodEnum.AUTO)))
                              {
                                 this._isProcessingDirectInteraction = true;
                              }
                              args = [SecureCenter.secure(ie2.instance),SelectEmptyItemMessage(msg).selectMethod];
                              break;
                           case msg is ItemRollOverMessage:
                              args = [SecureCenter.secure(ie2.instance),ItemRollOverMessage(msg).item];
                              break;
                           case msg is ItemRollOutMessage:
                              args = [SecureCenter.secure(ie2.instance),ItemRollOutMessage(msg).item];
                              break;
                           case msg is ItemRightClickMessage:
                              this._isProcessingDirectInteraction = true;
                              args = [SecureCenter.secure(ie2.instance),ItemRightClickMessage(msg).item];
                              break;
                           case msg is TextureReadyMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is TextureLoadFailMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is DropMessage:
                              this._isProcessingDirectInteraction = true;
                              args = [DropMessage(msg).target,DropMessage(msg).source];
                              break;
                           case msg is CreateTabMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is DeleteTabMessage:
                              args = [SecureCenter.secure(ie2.instance),DeleteTabMessage(msg).deletedIndex];
                              break;
                           case msg is RenameTabMessage:
                              args = [SecureCenter.secure(ie2.instance),RenameTabMessage(msg).index,RenameTabMessage(msg).name];
                              break;
                           case msg is MapElementRollOverMessage:
                              args = [SecureCenter.secure(ie2.instance),ReadOnlyObject.create(MapElementRollOverMessage(msg).targetedElement)];
                              break;
                           case msg is MapElementRollOutMessage:
                              args = [SecureCenter.secure(ie2.instance),ReadOnlyObject.create(MapElementRollOutMessage(msg).targetedElement)];
                              break;
                           case msg is MapElementRightClickMessage:
                              args = [SecureCenter.secure(ie2.instance),ReadOnlyObject.create(MapElementRightClickMessage(msg).targetedElement)];
                              break;
                           case msg is MapMoveMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is MapRollOverMessage:
                              args = [SecureCenter.secure(ie2.instance),MapRollOverMessage(msg).x,MapRollOverMessage(msg).y];
                              break;
                           case msg is VideoConnectFailedMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is VideoConnectSuccessMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is VideoBufferChangeMessage:
                              args = [SecureCenter.secure(ie2.instance),VideoBufferChangeMessage(msg).state];
                              break;
                           case msg is ComponentReadyMessage:
                              args = [SecureCenter.secure(ie2.instance)];
                              break;
                           case msg is TextClickMessage:
                              this._isProcessingDirectInteraction = true;
                              args = [SecureCenter.secure(ie2.instance),(msg as TextClickMessage).textEvent];
                              break;
                        }
                        if(args)
                        {
                           ModuleLogger.log(msg,ie2.instance);
                           args = SecureCenter.secureContent(args);
                           ErrorManager.tryFunction(GraphicContainer(ie2.instance).getUi().call,[ie2.callbackObject[targetFct],args,SecureCenter.ACCESS_KEY],"Erreur lors du traitement de " + msg);
                           this._isProcessingDirectInteraction = false;
                           return true;
                        }
                        break;
                     }
                     this.currentDo = this.currentDo.parent;
                  }
               }
               break;
         }
         this._isProcessingDirectInteraction = false;
         return false;
      }
      
      public function pushed() : Boolean {
         StageShareManager.stage.addEventListener(Event.RESIZE,this.onStageResize);
         return true;
      }
      
      public function pulled() : Boolean {
         StageShareManager.stage.removeEventListener(Event.RESIZE,this.onStageResize);
         return true;
      }
      
      private function processRegisteredUiEvent(msg:Message, gridInstance:Grid) : void {
         var args:Array = null;
         var fct:String = null;
         var ie:InstanceEvent = InstanceEvent(UIEventManager.getInstance().instances[this.currentDo]);
         var fctName:String = EventEnums.convertMsgToFct(getQualifiedClassName(msg));
         ModuleLogger.log(msg,ie.instance);
         if(gridInstance)
         {
            if(msg is MouseWheelMessage)
            {
               args = [SecureCenter.secure(ie.instance),MouseWheelMessage(msg).mouseEvent.delta];
            }
            else
            {
               args = [SecureCenter.secure(ie.instance)];
            }
            fct = gridInstance.renderer.eventModificator(msg,fctName,args,ie.instance as UIComponent);
            ErrorManager.tryFunction(CallWithParameters.call,[ie.callbackObject[fctName],args],"Erreur lors du traitement de " + msg);
         }
         else
         {
            if(msg is MouseWheelMessage)
            {
               ErrorManager.tryFunction(ie.callbackObject[fctName],[SecureCenter.secure(ie.instance),MouseWheelMessage(msg).mouseEvent.delta]);
            }
            else
            {
               ErrorManager.tryFunction(ie.callbackObject[fctName],[SecureCenter.secure(ie.instance)]);
            }
         }
      }
      
      private var _lastTs:uint = 0;
      
      private var _lastW:uint;
      
      private var _lastH:uint;
      
      private function onStageResize(e:Event=null) : void {
         if((this._lastW == StageShareManager.stage.stageWidth) && (this._lastH == StageShareManager.stage.stageHeight))
         {
            return;
         }
         if(getTimer() - this._lastTs > 100)
         {
            this._lastTs = getTimer();
            this._lastW = StageShareManager.stage.stageWidth;
            this._lastH = StageShareManager.stage.stageHeight;
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.WindowResize,this._lastW,this._lastH,StageShareManager.windowScale);
         }
         setTimeout(this.onStageResize,101);
      }
   }
}
