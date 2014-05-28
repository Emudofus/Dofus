package com.ankamagames.berilia.utils
{
   import com.ankamagames.jerakine.resources.protocols.impl.FileProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.data.XmlConfig;
   
   public class ThemeProtocol extends FileProtocol implements IProtocol
   {
      
      public function ThemeProtocol() {
         super();
      }
      
      private static var _themePath:String;
      
      override protected function loadDirectly(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, forcedAdapter:Class) : void {
         var path:String = null;
         getAdapter(uri,forcedAdapter);
         if(!_themePath)
         {
            _themePath = XmlConfig.getInstance().getEntry("config.ui.skin");
         }
         if(uri.protocol == "theme")
         {
            path = _themePath + uri.path;
         }
         else
         {
            path = uri.path;
         }
         _adapter.loadDirectly(uri,extractPath(path.split("file://").join("")),observer,dispatchProgress);
      }
   }
}
