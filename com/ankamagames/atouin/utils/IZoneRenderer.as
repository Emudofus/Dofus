package com.ankamagames.atouin.utils
{
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.types.DataMapContainer;
   
   public interface IZoneRenderer
   {
      
      function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean=false, param5:Boolean=false) : void;
      
      function remove(param1:Vector.<uint>, param2:DataMapContainer) : void;
   }
}
