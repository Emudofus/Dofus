package d2api
{
    public class SoundApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function activateSounds(pActivate:Boolean):void
        {
        }

        [Untrusted]
        public function soundsAreActivated():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function updaterAvailable():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function setBusVolume(pAudioBusId:uint, pVolume:uint):void
        {
        }

        [Untrusted]
        public function playSoundById(pSoundId:String):void
        {
        }

        [Untrusted]
        public function fadeBusVolume(pBusId:uint, pFade:Number, pFadeTime:uint):void
        {
        }

        [Untrusted]
        public function playSound(pSound:uint):void
        {
        }

        [Untrusted]
        public function playLookSound(pLook:String, pSoundType:uint):void
        {
        }

        [Trusted]
        public function playIntroMusic():void
        {
        }

        [Trusted]
        public function switchIntroMusic(pFirstHarmonic:Boolean=true):void
        {
        }

        [Trusted]
        public function stopIntroMusic():void
        {
        }

        [Untrusted]
        public function playSoundAtTurnStart():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function playSoundForGuildMessage():Boolean
        {
            return (false);
        }


    }
}//package d2api

