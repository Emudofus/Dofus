package com.ankamagames.dofus.logic.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.approach.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.*;
    import com.ankamagames.dofus.network.messages.security.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class MiscFrame extends Object implements Frame
    {
        private var _optionalAuthorizedFeatures:Array;
        private var _accountHouses:Vector.<AccountHouseInformations>;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MiscFrame));

        public function MiscFrame()
        {
            return;
        }// end function

        public function isOptionalFeatureActive(param1:uint) : Boolean
        {
            if (this._optionalAuthorizedFeatures.indexOf(param1) > -1)
            {
                return true;
            }
            return false;
        }// end function

        public function get accountHouses() : Vector.<AccountHouseInformations>
        {
            return this._accountHouses;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var mrcMsg:MouseRightClickMessage;
            var current:DisplayObject;
            var stage:Stage;
            var worldContainer:DisplayObjectContainer;
            var beriliaContainer:DisplayObjectContainer;
            var cfrmsg:CheckFileRequestMessage;
            var fileStream:FileStream;
            var fileByte:ByteArray;
            var value:String;
            var filenameHash:String;
            var cfmsg:CheckFileMessage;
            var sofmsg:ServerOptionalFeaturesMessage;
            var ahm:AccountHouseMessage;
            var file:File;
            var featureId:int;
            var msg:* = param1;
            switch(true)
            {
                case msg is MouseRightClickMessage:
                {
                    mrcMsg = msg as MouseRightClickMessage;
                    current = mrcMsg.target;
                    stage = StageShareManager.stage;
                    worldContainer = Atouin.getInstance().worldContainer;
                    beriliaContainer = Berilia.getInstance().docMain;
                    while (current != stage && current)
                    {
                        
                        if (beriliaContainer == current)
                        {
                            return false;
                        }
                        current = current.parent;
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.WorldRightClick);
                    return true;
                }
                case msg is CheckFileRequestMessage:
                {
                    cfrmsg = msg as CheckFileRequestMessage;
                    fileStream = new FileStream();
                    fileByte = new ByteArray();
                    value;
                    filenameHash = MD5.hash(cfrmsg.filename);
                    try
                    {
                        file = File.applicationDirectory;
                        if (!file || !file.exists)
                        {
                            value;
                        }
                        else
                        {
                            file = file.resolvePath("./" + cfrmsg.filename);
                            fileStream.open(file, FileMode.READ);
                            fileStream.readBytes(fileByte);
                            fileStream.close();
                        }
                    }
                    catch (e:Error)
                    {
                        if (e)
                        {
                            _log.error(e.getStackTrace());
                            value;
                        }
                    }
                    finally
                    {
                    }
                    return false;
        }// end function

        public function get priority() : int
        {
            return Priority.LOWEST;
        }// end function

    }
}
