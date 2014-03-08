package com.ankamagames.atouin.types
{
   import com.ankamagames.jerakine.managers.OptionManager;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   
   public dynamic class AtouinOptions extends OptionManager
   {
      
      public function AtouinOptions(param1:DisplayObjectContainer, param2:MessageHandler) {
         super("atouin");
         add("groundCacheMode",1);
         add("useInsideAutoZoom",AirScanner.isStreamingVersion());
         add("useCacheAsBitmap",true);
         add("useSmooth",true);
         add("frustum",new Frustum(),false);
         add("alwaysShowGrid",false);
         add("debugLayer",false);
         add("showCellIdOnOver",false);
         add("tweentInterMap",false);
         add("hideInterMap",AirScanner.isStreamingVersion());
         add("virtualPlayerJump",false);
         add("reloadLoadedMap",false);
         add("hideForeground",false);
         add("allowAnimatedGfx",true);
         add("allowParticlesFx",true);
         add("elementsPath");
         add("pngSubPath");
         add("jpgSubPath");
         add("mapsPath");
         add("elementsIndexPath");
         add("particlesScriptsPath");
         add("transparentOverlayMode",false);
         add("groundOnly",false);
         add("showTransitions",false);
         add("useLowDefSkin",true);
         add("showProgressBar",AirScanner.isStreamingVersion());
         add("mapPictoExtension","png");
         this._container = param1;
         this._handler = param2;
      }
      
      private var _container:DisplayObjectContainer;
      
      private var _handler:MessageHandler;
      
      public function get container() : DisplayObjectContainer {
         return this._container;
      }
      
      public function get handler() : MessageHandler {
         return this._handler;
      }
   }
}
