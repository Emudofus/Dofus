package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.jerakine.lua.LuaPackage;
   import com.ankamagames.dofus.misc.utils.Camera;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.dofus.scripts.ScriptEntity;
   
   public class CameraApi extends Object implements LuaPackage
   {
      
      public function CameraApi() {
         super();
         this._camera = new Camera();
      }
      
      private var _camera:Camera;
      
      public function get currentZoom() : Number {
         return this._camera.currentZoom;
      }
      
      public function set currentZoom(pZoom:Number) : void {
         this._camera.currentZoom = pZoom;
      }
      
      public function setZoom(pZoom:Number) : ISequencable {
         return this._camera.setZoom(pZoom);
      }
      
      public function zoom(... pArgs) : ISequencable {
         return this._camera.zoom(pArgs);
      }
      
      public function moveTo(... pArgs) : ISequencable {
         return this._camera.moveTo(pArgs);
      }
      
      public function follow(pEntity:ScriptEntity) : ISequencable {
         return this._camera.follow(pEntity);
      }
      
      public function stop() : ISequencable {
         return this._camera.stop();
      }
      
      public function resetCamera() : ISequencable {
         return this._camera.reset();
      }
      
      public function reset() : void {
         this._camera.stop().start();
         this._camera.reset().start();
      }
   }
}
