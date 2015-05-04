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
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.messages.ComponentMessage;
   import flash.geom.Point;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.berilia.types.event.InstanceEvent;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
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
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   
   public class UIInteractionFrame extends Object implements Frame
   {
      
      public function UIInteractionFrame()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UIInteractionFrame));
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      private var hierarchy:Array;
      
      private var currentDo:DisplayObject;
      
      private var _isProcessingDirectInteraction:Boolean;
      
      private var _warning:InputWarning;
      
      public function get isProcessingDirectInteraction() : Boolean
      {
         return this._isProcessingDirectInteraction;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:FocusChangeMessage = null;
         var _loc3_:UiRootContainer = null;
         var _loc4_:Input = null;
         var _loc5_:HumanInputMessage = null;
         var _loc6_:* = false;
         var _loc7_:* = false;
         var _loc8_:Grid = null;
         var _loc9_:* = false;
         var _loc10_:ComponentMessage = null;
         var _loc11_:Point = null;
         var _loc12_:KeyboardKeyDownMessage = null;
         var _loc13_:KeyboardKeyUpMessage = null;
         var _loc14_:UIComponent = null;
         var _loc15_:* = false;
         var _loc16_:MouseClickMessage = null;
         var _loc17_:UIComponent = null;
         var _loc18_:UIComponent = null;
         var _loc19_:Action = null;
         var _loc20_:String = null;
         var _loc21_:InstanceEvent = null;
         var _loc22_:Array = null;
         this._isProcessingDirectInteraction = false;
         this.currentDo = null;
         switch(true)
         {
            case param1 is FocusChangeMessage:
               _loc2_ = FocusChangeMessage(param1);
               this.hierarchy = new Array();
               this.currentDo = _loc2_.target;
               while(this.currentDo != null)
               {
                  if(this.currentDo is UIComponent)
                  {
                     this.hierarchy.unshift(this.currentDo);
                  }
                  this.currentDo = this.currentDo.parent;
               }
               _loc3_ = this.hierarchy[0] as UiRootContainer;
               _loc4_ = this.hierarchy[this.hierarchy.length - 1] as Input;
               if((this.hierarchy.length > 0 && _loc3_) && (_loc4_) && !_loc3_.uiData.module.trusted)
               {
                  if(!this._warning)
                  {
                     this._warning = new InputWarning();
                  }
                  Berilia.getInstance().docMain.addChild(this._warning);
                  this._warning.width = _loc4_.width;
                  _loc11_ = _loc4_.localToGlobal(new Point(_loc4_.x,_loc4_.y));
                  this._warning.x = _loc11_.x;
                  this._warning.y = _loc11_.y - this._warning.height - 4;
                  if(this._warning.y < 0)
                  {
                     this._warning.y = _loc11_.y + _loc4_.height + 4;
                  }
                  if(this._warning.y + this._warning.height > StageShareManager.startHeight)
                  {
                     this._warning.y = (StageShareManager.startHeight - this._warning.height) / 2;
                  }
               }
               else if((this._warning) && (this._warning.parent))
               {
                  this._warning.parent.removeChild(this._warning);
               }
               
               if(this.hierarchy.length > 0)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.FocusChange,SecureCenter.secure(this.hierarchy[this.hierarchy.length - 1]));
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.FocusChange,null);
               }
               return true;
            case param1 is HumanInputMessage:
               this._isProcessingDirectInteraction = true;
               _loc5_ = HumanInputMessage(param1);
               this.hierarchy = new Array();
               this.currentDo = _loc5_.target;
               while(this.currentDo != null)
               {
                  if(this.currentDo is UIComponent)
                  {
                     this.hierarchy.push(this.currentDo);
                  }
                  this.currentDo = this.currentDo.parent;
               }
               if(param1 is MouseClickMessage)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseClick,SecureCenter.secure(MouseClickMessage(param1).target));
                  if(!this.hierarchy[this.hierarchy.length - 1])
                  {
                     KernelEventsManager.getInstance().processCallback(BeriliaHookList.FocusChange,SecureCenter.secure(MouseClickMessage(param1).target));
                  }
               }
               if(param1 is MouseMiddleClickMessage)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseMiddleClick,SecureCenter.secure(MouseMiddleClickMessage(param1).target));
               }
               if(param1 is KeyboardKeyDownMessage)
               {
                  _loc12_ = KeyboardKeyDownMessage(param1);
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyDown,SecureCenter.secure(_loc12_.target),_loc12_.keyboardEvent.keyCode);
               }
               if(param1 is KeyboardKeyUpMessage)
               {
                  _loc13_ = KeyboardKeyUpMessage(param1);
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyUp,SecureCenter.secure(_loc13_.target),_loc13_.keyboardEvent.keyCode);
               }
               _loc6_ = false;
               _loc9_ = false;
               for each(_loc14_ in this.hierarchy)
               {
                  _loc7_ = UIComponent(_loc14_) is Grid;
                  if(!_loc6_ || (_loc7_))
                  {
                     _loc15_ = UIComponent(_loc14_).process(_loc5_);
                     if(_loc15_)
                     {
                        if((_loc7_) && !_loc5_.canceled)
                        {
                           _loc9_ = true;
                           _loc6_ = true;
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
                  if(!_loc8_ && (_loc7_))
                  {
                     _loc8_ = Grid(_loc14_);
                  }
               }
               this.currentDo = _loc5_.target;
               while(this.currentDo != null)
               {
                  if(this.currentDo is GraphicContainer)
                  {
                     UiSoundManager.getInstance().fromUiElement(this.currentDo as GraphicContainer,EventEnums.convertMsgToFct(getQualifiedClassName(param1)));
                  }
                  if(UIEventManager.getInstance().isRegisteredInstance(this.currentDo,param1))
                  {
                     _loc9_ = true;
                     this.processRegisteredUiEvent(param1,_loc8_);
                     break;
                  }
                  this.currentDo = this.currentDo.parent;
               }
               if(param1 is MouseClickMessage)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.PostMouseClick,SecureCenter.secure(MouseClickMessage(param1).target));
               }
               if(param1 is MouseDoubleClickMessage && !_loc9_)
               {
                  _loc16_ = GenericPool.get(MouseClickMessage,_loc5_.target as InteractiveObject,new MouseEvent(MouseEvent.CLICK));
                  Berilia.getInstance().handler.process(_loc16_);
               }
               this.hierarchy = null;
               this.currentDo = null;
               this._isProcessingDirectInteraction = false;
               break;
            case param1 is ComponentMessage:
               _loc10_ = ComponentMessage(param1);
               this.hierarchy = new Array();
               this.currentDo = _loc10_.target;
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
               for each(_loc17_ in this.hierarchy)
               {
                  UIComponent(_loc17_).process(_loc10_);
               }
               _loc10_.bubbling = true;
               this.hierarchy.reverse();
               this.hierarchy.pop();
               for each(_loc18_ in this.hierarchy)
               {
                  UIComponent(_loc18_).process(_loc10_);
               }
               this.hierarchy = null;
               if(!_loc10_.canceled)
               {
                  for each(_loc19_ in _loc10_.actions)
                  {
                     Berilia.getInstance().handler.process(_loc19_);
                  }
                  _loc20_ = EventEnums.convertMsgToFct(getQualifiedClassName(param1));
                  UiSoundManager.getInstance().fromUiElement(_loc10_.target as GraphicContainer,_loc20_);
                  this.currentDo = _loc10_.target;
                  while(this.currentDo != null)
                  {
                     if((UIEventManager.getInstance().instances[this.currentDo]) && (UIEventManager.getInstance().instances[this.currentDo].events[getQualifiedClassName(param1)]))
                     {
                        _loc21_ = InstanceEvent(UIEventManager.getInstance().instances[this.currentDo]);
                        switch(true)
                        {
                           case param1 is MouseMiddleClickMessage:
                           case param1 is ChangeMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is BrowserSessionTimeout:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is BrowserDomReady:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is ColorChangeMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is EntityReadyMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is SelectItemMessage:
                              if(!(SelectItemMessage(param1).selectMethod == SelectMethodEnum.MANUAL) && !(SelectItemMessage(param1).selectMethod == SelectMethodEnum.AUTO))
                              {
                                 this._isProcessingDirectInteraction = true;
                              }
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),SelectItemMessage(param1).selectMethod,SelectItemMessage(param1).isNewSelection];
                              break;
                           case param1 is SelectEmptyItemMessage:
                              if(!(SelectEmptyItemMessage(param1).selectMethod == SelectMethodEnum.MANUAL) && !(SelectEmptyItemMessage(param1).selectMethod == SelectMethodEnum.AUTO))
                              {
                                 this._isProcessingDirectInteraction = true;
                              }
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),SelectEmptyItemMessage(param1).selectMethod];
                              break;
                           case param1 is ItemRollOverMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),ItemRollOverMessage(param1).item];
                              break;
                           case param1 is ItemRollOutMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),ItemRollOutMessage(param1).item];
                              break;
                           case param1 is ItemRightClickMessage:
                              this._isProcessingDirectInteraction = true;
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),ItemRightClickMessage(param1).item];
                              break;
                           case param1 is TextureReadyMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is TextureLoadFailMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is DropMessage:
                              this._isProcessingDirectInteraction = true;
                              _loc22_ = [DropMessage(param1).target,DropMessage(param1).source];
                              break;
                           case param1 is CreateTabMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is DeleteTabMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),DeleteTabMessage(param1).deletedIndex];
                              break;
                           case param1 is RenameTabMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),RenameTabMessage(param1).index,RenameTabMessage(param1).name];
                              break;
                           case param1 is MapElementRollOverMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),ReadOnlyObject.create(MapElementRollOverMessage(param1).targetedElement)];
                              break;
                           case param1 is MapElementRollOutMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),ReadOnlyObject.create(MapElementRollOutMessage(param1).targetedElement)];
                              break;
                           case param1 is MapElementRightClickMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),ReadOnlyObject.create(MapElementRightClickMessage(param1).targetedElement)];
                              break;
                           case param1 is MapMoveMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is MapRollOverMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),MapRollOverMessage(param1).x,MapRollOverMessage(param1).y];
                              break;
                           case param1 is VideoConnectFailedMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is VideoConnectSuccessMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is VideoBufferChangeMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),VideoBufferChangeMessage(param1).state];
                              break;
                           case param1 is ComponentReadyMessage:
                              _loc22_ = [SecureCenter.secure(_loc21_.instance)];
                              break;
                           case param1 is TextClickMessage:
                              this._isProcessingDirectInteraction = true;
                              _loc22_ = [SecureCenter.secure(_loc21_.instance),(param1 as TextClickMessage).textEvent];
                              break;
                        }
                        if(_loc22_)
                        {
                           ModuleLogger.log(param1,_loc21_.instance);
                           _loc22_ = SecureCenter.secureContent(_loc22_);
                           ErrorManager.tryFunction(GraphicContainer(_loc21_.instance).getUi().call,[_loc21_.callbackObject[_loc20_],_loc22_,SecureCenter.ACCESS_KEY],"Erreur lors du traitement de " + param1);
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
      
      public function pushed() : Boolean
      {
         StageShareManager.stage.addEventListener(Event.RESIZE,this.onStageResize);
         if(AirScanner.hasAir())
         {
            StageShareManager.stage.nativeWindow.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         }
         return true;
      }
      
      public function pulled() : Boolean
      {
         StageShareManager.stage.removeEventListener(Event.RESIZE,this.onStageResize);
         if(AirScanner.hasAir())
         {
            StageShareManager.stage.nativeWindow.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         }
         if((this._warning) && (this._warning.parent))
         {
            this._warning.parent.removeChild(this._warning);
         }
         this._warning = null;
         return true;
      }
      
      private function processRegisteredUiEvent(param1:Message, param2:Grid) : void
      {
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc3_:InstanceEvent = InstanceEvent(UIEventManager.getInstance().instances[this.currentDo]);
         var _loc4_:String = EventEnums.convertMsgToFct(getQualifiedClassName(param1));
         ModuleLogger.log(param1,_loc3_.instance);
         if(param2)
         {
            if(param1 is MouseWheelMessage)
            {
               _loc5_ = [SecureCenter.secure(_loc3_.instance),MouseWheelMessage(param1).mouseEvent.delta];
            }
            else
            {
               _loc5_ = [SecureCenter.secure(_loc3_.instance)];
            }
            _loc6_ = param2.renderer.eventModificator(param1,_loc4_,_loc5_,_loc3_.instance as UIComponent);
            ErrorManager.tryFunction(CallWithParameters.call,[_loc3_.callbackObject[_loc4_],_loc5_],"Erreur lors du traitement de " + param1);
         }
         else if(param1 is MouseWheelMessage)
         {
            ErrorManager.tryFunction(_loc3_.callbackObject[_loc4_],[SecureCenter.secure(_loc3_.instance),MouseWheelMessage(param1).mouseEvent.delta]);
         }
         else
         {
            ErrorManager.tryFunction(_loc3_.callbackObject[_loc4_],[SecureCenter.secure(_loc3_.instance)]);
         }
         
      }
      
      private var _lastTs:uint = 0;
      
      private var _lastW:uint;
      
      private var _lastH:uint;
      
      private function onStageResize(param1:Event = null) : void
      {
         if(this._lastW == StageShareManager.stage.stageWidth && this._lastH == StageShareManager.stage.stageHeight)
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
      
      private function onWindowDeactivate(param1:Event) : void
      {
         if((Berilia.getInstance().docMain) && (Berilia.getInstance().docMain.stage))
         {
            Berilia.getInstance().docMain.stage.focus = null;
            FocusHandler.getInstance().setFocus(null);
         }
      }
   }
}
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import com.ankamagames.jerakine.data.I18n;

class InputWarning extends TextField
{
   
   function InputWarning()
   {
      super();
      background = true;
      backgroundColor = 7348259;
      autoSize = TextFieldAutoSize.LEFT;
      wordWrap = true;
      defaultTextFormat = new TextFormat("Verdana",12,16777215,true);
      text = I18n.getUiText("ui.module.input.warning");
   }
}
