package cmodule.lua_wrapper
{
   import flash.display.Sprite;
   
   public class ConSprite extends Sprite
   {
      
      public function ConSprite() {
         this.runner = new CRunner();
         super();
         if(ConSprite)
         {
            log(1,"More than one sprite!");
         }
         var ConSprite:* = this;
         this.runner.startSystem();
      }
      
      private var runner:CRunner;
   }
}
