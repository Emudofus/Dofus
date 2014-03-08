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
      
      override protected function loadDirectly(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, forcedAdapter:Class) : void {
         getAdapter(uri,forcedAdapter);
         var moduleName:String = uri.path.substr(0,uri.path.indexOf("/"));
         var path:String = UiModuleManager.getInstance().getModulePath(moduleName);
         var addPath:String = uri.path.substr(uri.path.indexOf("/"));
         if((!(path.charAt(path.length - 1) == "/")) && (!(addPath.charAt(0) == "/")))
         {
            path = path + "/";
         }
         if((path.charAt(path.length - 1) == "/") && (addPath.charAt(0) == "/"))
         {
            addPath = addPath.substr(1);
         }
         path = path + addPath;
         _adapter.loadDirectly(uri,extractPath(path),observer,dispatchProgress);
      }
   }
}
