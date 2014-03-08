package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.interfaces.IRadioItem;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.interfaces.IDragAndDropHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.RadioGroup;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   
   public class ButtonContainer extends StateContainer implements IRadioItem, FinalizableUIComponent, IDragAndDropHandler
   {
      
      public function ButtonContainer() {
         super();
         buttonMode = true;
         useHandCursor = true;
         mouseEnabled = true;
         mouseChildren = false;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ButtonContainer));
      
      private var _selected:Boolean = false;
      
      protected var _mousePressed:Boolean = false;
      
      protected var _disabled:Boolean = false;
      
      private var _radioGroup:String;
      
      private var _value;
      
      private var _lastClickFameId:uint = 4.294967295E9;
      
      private var _checkbox:Boolean = false;
      
      private var _radioMode:Boolean = false;
      
      protected var _sLinkedTo:String;
      
      protected var _soundId:String = "0";
      
      protected var _playRollOverSound:Boolean = true;
      
      protected var _isMute:Boolean = false;
      
      protected var _finalized:Boolean;
      
      public function set checkBox(param1:Boolean) : void {
         this._checkbox = param1;
         this._radioMode = !param1 && (this._radioMode);
      }
      
      public function get checkBox() : Boolean {
         return this._checkbox;
      }
      
      public function set radioMode(param1:Boolean) : void {
         this._radioMode = param1;
         this._checkbox = !param1 && (this._checkbox);
      }
      
      public function get radioMode() : Boolean {
         return this._radioMode;
      }
      
      override public function set linkedTo(param1:String) : void {
         this._sLinkedTo = param1;
      }
      
      override public function get linkedTo() : String {
         return this._sLinkedTo;
      }
      
      public function set radioGroup(param1:String) : void {
         if(param1 == "")
         {
            this._radioGroup = null;
         }
         else
         {
            this._radioGroup = param1;
         }
      }
      
      public function get radioGroup() : String {
         return this._radioGroup;
      }
      
      public function get mousePressed() : Boolean {
         return this._mousePressed;
      }
      
      public function set selected(param1:Boolean) : void {
         var _loc2_:RadioGroup = null;
         this._selected = param1;
         if(changingStateData)
         {
            if(!changingStateData[param1?StatesEnum.STATE_SELECTED:StatesEnum.STATE_NORMAL])
            {
               this.state = this._selected?StatesEnum.STATE_SELECTED:StatesEnum.STATE_NORMAL;
            }
            else
            {
               this.state = param1?StatesEnum.STATE_SELECTED:StatesEnum.STATE_NORMAL;
            }
         }
         if((this._radioGroup) && (getUi()))
         {
            _loc2_ = getUi().getRadioGroup(this._radioGroup);
            if(_loc2_)
            {
               _loc2_.selectedItem = this;
            }
         }
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      override public function set state(param1:*) : void {
         if(_state == param1)
         {
            return;
         }
         switch(param1)
         {
            case StatesEnum.STATE_NORMAL:
               _state = param1;
               restoreSnapshot(StatesEnum.STATE_NORMAL);
               break;
            case StatesEnum.STATE_DISABLED:
               this._disabled = true;
            case StatesEnum.STATE_SELECTED:
            case StatesEnum.STATE_CLICKED:
            case StatesEnum.STATE_OVER:
            case StatesEnum.STATE_SELECTED_CLICKED:
            case StatesEnum.STATE_SELECTED_OVER:
               if(!softDisabled)
               {
                  changeState(param1);
                  _state = param1;
               }
               break;
         }
      }
      
      public function get id() : String {
         return name;
      }
      
      public function get value() : * {
         return this._value;
      }
      
      public function set value(param1:*) : void {
         this._value = param1;
      }
      
      public function finalize() : void {
         var _loc1_:UiRootContainer = null;
         var _loc2_:RadioGroup = null;
         if(this._radioGroup)
         {
            _loc1_ = getUi();
            _loc2_ = _loc1_.addRadioGroup(this._radioGroup);
            _loc2_.addItem(this);
         }
         if(this._selected)
         {
            this.selected = this._selected;
         }
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
         this._finalized = true;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      public function get soundId() : String {
         return this._soundId;
      }
      
      public function set soundId(param1:String) : void {
         this._soundId = param1;
      }
      
      public function get isMute() : Boolean {
         return this._isMute;
      }
      
      public function set isMute(param1:Boolean) : void {
         this._isMute = param1;
      }
      
      public function reset() : void {
         _snapshot = new Array();
         this.selected = false;
         _state = StatesEnum.STATE_NORMAL;
      }
      
      override public function free() : void {
         super.free();
         this._selected = false;
         this._mousePressed = false;
         this._disabled = false;
         this._radioGroup = null;
         this._value = null;
         this._checkbox = false;
         this._radioMode = false;
         this._sLinkedTo = null;
      }
      
      override public function remove() : void {
         super.remove();
         this.free();
      }
      
      protected function selectSound() : String {
         if(this._soundId != "0")
         {
            return this._soundId;
         }
         switch(true)
         {
            case this.checkBox:
               if(this.selected)
               {
                  return "16006";
               }
               return "16007";
            default:
               return "16004";
         }
      }
      
      override public function process(param1:Message) : Boolean {
         var _loc3_:IInterfaceListener = null;
         var _loc4_:String = null;
         var _loc5_:IInterfaceListener = null;
         var _loc6_:RadioGroup = null;
         var _loc7_:GraphicContainer = null;
         var _loc2_:uint = 9999;
         if(!super.canProcessMessage(param1))
         {
            return true;
         }
         if(!this._disabled)
         {
            switch(true)
            {
               case param1 is MouseDownMessage:
                  this._mousePressed = true;
                  _loc2_ = this._selected?StatesEnum.STATE_SELECTED_CLICKED:StatesEnum.STATE_CLICKED;
                  break;
               case param1 is MouseDoubleClickMessage:
               case param1 is MouseClickMessage:
                  this._mousePressed = false;
                  if(this._lastClickFameId == FrameIdManager.frameId)
                  {
                     break;
                  }
                  this._lastClickFameId = FrameIdManager.frameId;
                  if(this._checkbox)
                  {
                     this._selected = !this._selected;
                  }
                  else
                  {
                     if(this._radioMode)
                     {
                        this._selected = true;
                     }
                  }
                  _loc2_ = this._selected?StatesEnum.STATE_SELECTED_OVER:StatesEnum.STATE_OVER;
                  if(!changingStateData[_loc2_])
                  {
                     _loc2_ = this._selected?StatesEnum.STATE_SELECTED:StatesEnum.STATE_NORMAL;
                  }
                  if(!this.isMute)
                  {
                     for each (_loc3_ in Berilia.getInstance().UISoundListeners)
                     {
                        _loc4_ = this.selectSound();
                        if(int(_loc4_) != -1)
                        {
                           _loc3_.playUISound(_loc4_);
                        }
                     }
                  }
                  break;
               case param1 is MouseOverMessage:
                  if(this._mousePressed)
                  {
                     _loc2_ = this._selected?StatesEnum.STATE_SELECTED_CLICKED:StatesEnum.STATE_CLICKED;
                  }
                  else
                  {
                     if((this._playRollOverSound) && !this.isMute)
                     {
                        for each (_loc5_ in Berilia.getInstance().UISoundListeners)
                        {
                           _loc5_.playUISound("16010");
                        }
                     }
                     _loc2_ = this._selected?StatesEnum.STATE_SELECTED_OVER:StatesEnum.STATE_OVER;
                     if((changingStateData) && !changingStateData[_loc2_])
                     {
                        _loc2_ = this._selected?StatesEnum.STATE_SELECTED:StatesEnum.STATE_NORMAL;
                     }
                  }
                  break;
               case param1 is MouseReleaseOutsideMessage:
                  this._mousePressed = false;
               case param1 is MouseOutMessage:
                  _loc2_ = this._selected?StatesEnum.STATE_SELECTED:StatesEnum.STATE_NORMAL;
                  break;
            }
         }
         if(_loc2_ != 9999)
         {
            this.state = _loc2_;
            if((this._radioGroup) && (this._selected))
            {
               _loc6_ = getUi().getRadioGroup(this._radioGroup);
               if(_loc6_)
               {
                  _loc6_.selectedItem = this;
               }
            }
         }
         if(this._sLinkedTo)
         {
            _loc7_ = getUi().getElement(this._sLinkedTo);
            if(_loc7_)
            {
               _loc7_.process(param1);
            }
         }
         return false;
      }
   }
}
