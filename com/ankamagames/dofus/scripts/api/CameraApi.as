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
      
      public function set currentZoom(param1:Number) : void {
         this._camera.currentZoom = param1;
      }
      
      public function setZoom(param1:Number) : ISequencable {
         return this._camera.setZoom(param1);
      }
      
      public function zoom(... rest) : ISequencable {
         return this._camera.zoom(rest);
      }
      
      public function moveTo(... rest) : ISequencable {
         return this._camera.moveTo(rest);
      }
      
      public function follow(param1:ScriptEntity) : ISequencable {
         return this._camera.follow(param1);
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
