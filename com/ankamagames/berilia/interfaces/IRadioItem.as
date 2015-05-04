package com.ankamagames.berilia.interfaces
{
   public interface IRadioItem
   {
      
      function get id() : String;
      
      function set value(param1:*) : void;
      
      function get value() : *;
      
      function set selected(param1:Boolean) : void;
      
      function get selected() : Boolean;
   }
}
