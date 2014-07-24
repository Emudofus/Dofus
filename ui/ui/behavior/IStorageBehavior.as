package ui.behavior
{
   import ui.AbstractStorageUi;
   
   public interface IStorageBehavior
   {
      
      function dropValidator(param1:Object, param2:Object, param3:Object) : Boolean;
      
      function processDrop(param1:Object, param2:Object, param3:Object) : void;
      
      function attach(param1:AbstractStorageUi) : void;
      
      function detach() : void;
      
      function filterStatus(param1:Boolean) : void;
      
      function onRelease(param1:Object) : void;
      
      function onSelectItem(param1:Object, param2:uint, param3:Boolean) : void;
      
      function onUnload() : void;
      
      function getStorageUiName() : String;
      
      function getName() : String;
      
      function get replacable() : Boolean;
   }
}
