package d2api
{
    public class TimeApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getTimestamp():Number
        {
            return (0);
        }

        [Untrusted]
        public function getUtcTimestamp():Number
        {
            return (0);
        }

        [Untrusted]
        public function getClock(time:Number=0, unchanged:Boolean=false, useTimezoneOffset:Boolean=false):String
        {
            return (null);
        }

        [Untrusted]
        public function getClockNumbers():Object
        {
            return (null);
        }

        [Untrusted]
        public function getDate(time:Number=0, useTimezoneOffset:Boolean=false, unchanged:Boolean=false):String
        {
            return (null);
        }

        [Untrusted]
        public function getDofusDate(time:Number=0):String
        {
            return (null);
        }

        [Untrusted]
        public function getDofusDay(time:Number=0):int
        {
            return (0);
        }

        [Untrusted]
        public function getDofusMonth(time:Number=0):String
        {
            return (null);
        }

        [Untrusted]
        public function getDofusYear(time:Number=0):String
        {
            return (null);
        }

        [Untrusted]
        public function getDurationTimeSinceEpoch(pTime:Number=0):Number
        {
            return (0);
        }

        [Untrusted]
        public function getDuration(time:Number, second:Boolean=false):String
        {
            return (null);
        }

        [Untrusted]
        public function getShortDuration(time:Number, second:Boolean=false):String
        {
            return (null);
        }

        [Untrusted]
        public function getTimezoneOffset():Number
        {
            return (0);
        }


    }
}//package d2api

