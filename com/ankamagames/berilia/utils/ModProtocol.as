package com.ankamagames.berilia.utils
{
   import com.ankamagames.jerakine.resources.protocols.impl.FileProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.berilia.managers.UiModuleManager;
   
   public class ModProtocol extends FileProtocol implements IProtocol
   {
      
      public function ModProtocol() {
         super();
      }
      
      override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void {
         getAdapter(param1,param4);
         var _loc5_:String = param1.path.substr(0,param1.path.indexOf("/"));
         var _loc6_:String = UiModuleManager.getInstance().getModulePath(_loc5_);
         var _loc7_:String = param1.path.substr(param1.path.indexOf("/"));
         if(!(_loc6_.charAt(_loc6_.length-1) == "/") && !(_loc7_.charAt(0) == "/"))
         {
            _loc6_ = _loc6_ + "/";
         }
         if(_loc6_.charAt(_loc6_.length-1) == "/" && _loc7_.charAt(0) == "/")
         {
            _loc7_ = _loc7_.substr(1);
         }
         _loc6_ = _loc6_ + _loc7_;
         _adapter.loadDirectly(param1,extractPath(_loc6_),param2,param3);
      }
   }
}
