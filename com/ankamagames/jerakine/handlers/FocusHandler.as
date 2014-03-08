package com.ankamagames.jerakine.handlers
{
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   
   public class FocusHandler extends Object
   {
      
      public function FocusHandler() {
         super();
         if(_self != null)
         {
            throw new SingletonError("FocusHandler constructor should not be called directly.");
         }
         else
         {
            StageShareManager.stage.stageFocusRect = false;
            return;
         }
      }
      
      private static var _self:FocusHandler;
      
      private static var _currentFocus:WeakReference;
      
      public static function getInstance() : FocusHandler {
         if(_self == null)
         {
            _self = new FocusHandler();
         }
         return _self;
      }
      
      public function setFocus(param1:InteractiveObject) : void {
         _currentFocus = new WeakReference(param1);
      }
      
      public function getFocus() : InteractiveObject {
         return _currentFocus?_currentFocus.object as InteractiveObject:null;
      }
      
      public function hasFocus(param1:InteractiveObject) : Boolean {
         if(_currentFocus)
         {
            return _currentFocus.object == param1;
         }
         return false;
      }
   }
}
