package com.ankamagames.dofus.kernel.sound.manager
{
    import com.ankamagames.tubul.interfaces.ILocalizedSoundListener;
    import com.ankamagames.jerakine.interfaces.IInterfaceListener;
    import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
    import com.ankamagames.jerakine.interfaces.ISoundPositionListener;
    import com.ankamagames.atouin.data.map.Map;
    import com.ankamagames.tubul.interfaces.ISound;
    import com.ankamagames.tubul.types.VolumeFadeEffect;

    public interface ISoundManager extends ILocalizedSoundListener, IInterfaceListener, IFLAEventHandler, ISoundPositionListener 
    {

        function set soundDirectoryExist(_arg_1:Boolean):void;
        function get soundDirectoryExist():Boolean;
        function get soundIsActivate():Boolean;
        function retriveXMLSounds():void;
        function retriveRollOffPresets():void;
        function setSubArea(_arg_1:Map=null):void;
        function playSound(_arg_1:ISound, _arg_2:Boolean=false, _arg_3:int=-1):ISound;
        function playFightMusic():void;
        function prepareFightMusic():void;
        function stopFightMusic():void;
        function applyDynamicMix(_arg_1:VolumeFadeEffect, _arg_2:uint, _arg_3:VolumeFadeEffect):void;
        function playIntroMusic(_arg_1:Boolean=true):void;
        function switchIntroMusic(_arg_1:Boolean):void;
        function stopIntroMusic(_arg_1:Boolean=false):void;
        function removeAllSounds(_arg_1:Number=0, _arg_2:Number=0):void;
        function reset():void;
        function fadeBusVolume(_arg_1:int, _arg_2:Number, _arg_3:Number):void;
        function setBusVolume(_arg_1:int, _arg_2:Number):void;
        function activateSound():void;
        function deactivateSound():void;
        function playAdminSound(_arg_1:String, _arg_2:Number, _arg_3:Boolean, _arg_4:uint):void;
        function stopAdminSound(_arg_1:uint):void;
        function addSoundInPlaylist(_arg_1:String, _arg_2:Number, _arg_3:uint, _arg_4:uint):Boolean;
        function removeSoundInPLaylist(_arg_1:String):Boolean;
        function playPlaylist():void;
        function stopPlaylist():void;
        function resetPlaylist():void;

    }
}//package com.ankamagames.dofus.kernel.sound.manager

