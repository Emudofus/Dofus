package com.ankamagames.dofus.datacenter.items.criterion
{
   import __AS3__.vec.Vector;


   public interface IItemCriterion
   {
         



      function get inlineCriteria() : Vector.<IItemCriterion>;

      function get isRespected() : Boolean;

      function get text() : String;

      function get basicText() : String;

      function clone() : IItemCriterion;
   }

}