package d2api
{
   public class TimeApi extends Object
   {
      
      public function TimeApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getTimestamp() : Number {
         return 0;
      }
      
      public function getUtcTimestamp() : Number {
         return 0;
      }
      
      public function getClock(time:Number = 0, unchanged:Boolean = false, useTimezoneOffset:Boolean = false) : String {
         return null;
      }
      
      public function getClockNumbers() : Object {
         return null;
      }
      
      public function getDate(time:Number = 0, useTimezoneOffset:Boolean = false) : String {
         return null;
      }
      
      public function getDofusDate(time:Number = 0) : String {
         return null;
      }
      
      public function getDofusDay(time:Number = 0) : int {
         return 0;
      }
      
      public function getDofusMonth(time:Number = 0) : String {
         return null;
      }
      
      public function getDofusYear(time:Number = 0) : String {
         return null;
      }
      
      public function getDurationTimeSinceEpoch(pTime:Number = 0) : Number {
         return 0;
      }
      
      public function getDuration(time:Number, second:Boolean = false) : String {
         return null;
      }
      
      public function getShortDuration(time:Number, second:Boolean = false) : String {
         return null;
      }
      
      public function getTimezoneOffset() : Number {
         return 0;
      }
   }
}
