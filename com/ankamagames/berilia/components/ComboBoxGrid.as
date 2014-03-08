package com.ankamagames.berilia.components
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMessage;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.components.messages.SelectEmptyItemMessage;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   
   public class ComboBoxGrid extends Grid
   {
      
      public function ComboBoxGrid() {
         super();
      }
      
      private var _lastMouseUpFrameId:int = -1;
      
      override public function process(param1:Message) : Boolean {
         var _loc2_:MouseMessage = null;
         var _loc3_:* = undefined;
         switch(true)
         {
            case param1 is MouseDoubleClickMessage:
            case param1 is MouseClickMessage:
               if(this._lastMouseUpFrameId == FrameIdManager.frameId)
               {
                  return false;
               }
            case param1 is MouseUpMessage:
               this._lastMouseUpFrameId = FrameIdManager.frameId;
               _loc2_ = MouseMessage(param1);
               _loc3_ = super.getGridItem(_loc2_.target);
               if(_loc3_)
               {
                  if(!_loc3_.data)
                  {
                     if(UIEventManager.getInstance().isRegisteredInstance(this,SelectEmptyItemMessage))
                     {
                        super.dispatchMessage(new SelectEmptyItemMessage(this,SelectMethodEnum.CLICK));
                     }
                     setSelectedIndex(-1,SelectMethodEnum.CLICK);
                  }
                  setSelectedIndex(_loc3_.index,SelectMethodEnum.CLICK);
               }
               return true;
            default:
               super.process(param1);
               return false;
         }
      }
   }
}
