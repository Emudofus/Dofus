package org.flintparticles.common.utils
{


   public class Maths extends Object
   {
         

      public function Maths() {
         super();
      }

      private static const RADTODEG:Number = 180/Math.PI;

      private static const DEGTORAD:Number = Math.PI/180;

      public static function asDegrees(radians:Number) : Number {
         return radians*RADTODEG;
      }

      public static function asRadians(degrees:Number) : Number {
         return degrees*DEGTORAD;
      }


   }

}