package com.ankamagames.jerakine.network
{
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.scrambling.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class NetworkMessage extends ScramblableElement implements INetworkMessage
    {
        public static const BIT_RIGHT_SHIFT_LEN_PACKET_ID:uint = 2;
        public static const BIT_MASK:uint = 3;

        public function NetworkMessage()
        {
            return;
        }// end function

        public function get isInitialized() : Boolean
        {
            throw new AbstractMethodCallError();
        }// end function

        public function getMessageId() : uint
        {
            throw new AbstractMethodCallError();
        }// end function

        public function reset() : void
        {
            throw new AbstractMethodCallError();
        }// end function

        public function pack(param1:IDataOutput) : void
        {
            throw new AbstractMethodCallError();
        }// end function

        public function unpack(param1:IDataInput, param2:uint) : void
        {
            throw new AbstractMethodCallError();
        }// end function

        public function readExternal(param1:IDataInput) : void
        {
            throw new AbstractMethodCallError();
        }// end function

        public function writeExternal(param1:IDataOutput) : void
        {
            throw new AbstractMethodCallError();
        }// end function

        public static function writePacket(param1:IDataOutput, param2:int, param3:ByteArray) : void
        {
            var _loc_5:uint = 0;
            var _loc_6:uint = 0;
            var _loc_4:* = computeTypeLen(param3.length);
            param1.writeShort(subComputeStaticHeader(param2, _loc_4));
            switch(_loc_4)
            {
                case 0:
                {
                    return;
                }
                case 1:
                {
                    param1.writeByte(param3.length);
                    break;
                }
                case 2:
                {
                    param1.writeShort(param3.length);
                    break;
                }
                case 3:
                {
                    _loc_5 = param3.length >> 16 & 255;
                    _loc_6 = param3.length & 65535;
                    param1.writeByte(_loc_5);
                    param1.writeShort(_loc_6);
                    break;
                }
                default:
                {
                    break;
                }
            }
            param1.writeBytes(param3, 0, param3.length);
            return;
        }// end function

        private static function computeTypeLen(param1:uint) : uint
        {
            if (param1 > 65535)
            {
                return 3;
            }
            if (param1 > 255)
            {
                return 2;
            }
            if (param1 > 0)
            {
                return 1;
            }
            return 0;
        }// end function

        private static function subComputeStaticHeader(param1:uint, param2:uint) : uint
        {
            return param1 << BIT_RIGHT_SHIFT_LEN_PACKET_ID | param2;
        }// end function

    }
}
