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
      
      override public function process(msg:Message) : Boolean {
         var mmsg:MouseMessage = null;
         var currentItem:* = undefined;
         switch(true)
         {
            case msg is MouseDoubleClickMessage:
            case msg is MouseClickMessage:
               if(this._lastMouseUpFrameId == FrameIdManager.frameId)
               {
                  return false;
               }
            case msg is MouseUpMessage:
               this._lastMouseUpFrameId = FrameIdManager.frameId;
               mmsg = MouseMessage(msg);
               currentItem = super.getGridItem(mmsg.target);
               if(currentItem)
               {
                  if(!currentItem.data)
                  {
                     if(UIEventManager.getInstance().isRegisteredInstance(this,SelectEmptyItemMessage))
                     {
                        super.dispatchMessage(new SelectEmptyItemMessage(this,SelectMethodEnum.CLICK));
                     }
                     setSelectedIndex(-1,SelectMethodEnum.CLICK);
                  }
                  setSelectedIndex(currentItem.index,SelectMethodEnum.CLICK);
               }
               return true;
            default:
               super.process(msg);
               return false;
         }
      }
   }
}
