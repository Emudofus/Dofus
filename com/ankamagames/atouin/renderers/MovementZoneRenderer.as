package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;


   public class MovementZoneRenderer extends ZoneDARenderer
   {
         

      public function MovementZoneRenderer(showText:Boolean, startAt:int=1) {
         super();
         this._showText=showText;
         this._startAt=startAt;
         strata=PlacementStrataEnums.STRATA_AREA;
      }



      private var _showText:Boolean;

      private var _startAt:int;

      override protected function getText(count:int) : String {
         if(this._showText)
         {
            return String(count+this._startAt);
         }
         return null;
      }
   }

}