package com.ankamagames.jerakine.entities.interfaces
{
   public interface IAnimated
   {
      
      function getDirection() : uint;
      
      function setDirection(param1:uint) : void;
      
      function getAnimation() : String;
      
      function setAnimation(param1:String) : void;
      
      function setAnimationAndDirection(param1:String, param2:uint, param3:Boolean = false) : void;
   }
}
