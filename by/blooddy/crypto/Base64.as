package by.blooddy.crypto
{
    import flash.system.*;
    import flash.utils.*;

    public class Base64 extends Object
    {

        public function Base64() : void
        {
            return;
        }// end function

        public static function encode(param1:ByteArray, param2:Boolean = false) : String
        {
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_3:* = param1.length;
            var _loc_4:* = ApplicationDomain.currentDomain.domainMemory;
            var _loc_5:* = new ByteArray();
            new ByteArray().writeUTFBytes("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/");
            _loc_5.writeBytes(param1);
            var _loc_6:* = _loc_3 % 3;
            var _loc_7:* = 64 + _loc_3 - _loc_6 - 1;
            var _loc_8:* = (_loc_3 / 3 << 2) + (_loc_6 > 0 ? (4) : (0));
            _loc_5.length = _loc_5.length + (_loc_8 + (param2 ? (_loc_8 / 76) : (0)));
            if (_loc_5.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _loc_5.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            ApplicationDomain.currentDomain.domainMemory = _loc_5;
            var _loc_9:* = 63;
            var _loc_10:* = 64 + _loc_3;
            while (_loc_9 < _loc_7)
            {
                
                _loc_9 = ++_loc_9 + 1;
                _loc_11 = ++_loc_9 << 16 | _loc_9 << 8 | ++_loc_9;
                _loc_10 = _loc_10 + 4;
                if (param2)
                {
                }
                if ((++_loc_9 - 64 + 1) % 57 == 0)
                {
                    _loc_12 = _loc_10;
                    _loc_10 = _loc_10 + 1;
                }
            }
            switch(_loc_6) branch count is:<2>[14, 18, 58] default offset is:<14>;
            ;
            ;
            _loc_9 = ++_loc_9 + 1;
            _loc_11 = _loc_9 << 8 | ++_loc_9;
            _loc_5.position = 64 + _loc_3;
            var _loc_13:* = _loc_5.readUTFBytes(_loc_5.bytesAvailable);
            ApplicationDomain.currentDomain.domainMemory = _loc_4;
            return _loc_13;
        }// end function

        public static function decode(param1:String) : ByteArray
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_2:* = param1.length * 0.75;
            var _loc_3:* = ApplicationDomain.currentDomain.domainMemory;
            var _loc_4:* = new ByteArray();
            new ByteArray().writeUTFBytes("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@>@@@?456789:;<=@@@@@@@");
            _loc_4.writeUTFBytes(param1);
            var _loc_5:* = _loc_4.length - 4 - 1;
            if (_loc_4.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
                _loc_4.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            ApplicationDomain.currentDomain.domainMemory = _loc_4;
            var _loc_6:* = 204 == 10;
            var _loc_7:* = 127;
            var _loc_8:* = 127;
            while (++_loc_7 < _loc_5)
            {
                
                if ((++_loc_7 & 128) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                if (++_loc_7 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                _loc_9 = _loc_13;
                _loc_7 = ++_loc_7 + 1;
                _loc_13 = _loc_7;
                if ((_loc_13 & 128) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                _loc_13 = _loc_13;
                if (_loc_13 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                _loc_10 = _loc_13;
                if ((++_loc_7 & 128) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                if (++_loc_7 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                _loc_11 = _loc_13;
                _loc_7 = ++_loc_7 + 1;
                _loc_13 = _loc_7;
                if ((_loc_13 & 128) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                _loc_13 = _loc_13;
                if (_loc_13 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                _loc_12 = _loc_13;
                _loc_8 = ++_loc_8 + 1;
                if (_loc_6)
                {
                    if ((++_loc_8 - 128 + 1) % 57 == 0)
                    {
                    }
                }
                if (++_loc_7 != 10)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
            }
            if (_loc_7 != _loc_5)
            {
                ApplicationDomain.currentDomain.domainMemory = _loc_3;
                Error.throwError(VerifyError, 1509);
            }
            if ((++_loc_7 & 128) != 0)
            {
                ApplicationDomain.currentDomain.domainMemory = _loc_3;
                Error.throwError(VerifyError, 1509);
            }
            if (++_loc_7 == 64)
            {
                ApplicationDomain.currentDomain.domainMemory = _loc_3;
                Error.throwError(VerifyError, 1509);
            }
            _loc_9 = _loc_13;
            _loc_7 = ++_loc_7 + 1;
            _loc_13 = _loc_7;
            if ((_loc_13 & 128) != 0)
            {
                ApplicationDomain.currentDomain.domainMemory = _loc_3;
                Error.throwError(VerifyError, 1509);
            }
            _loc_13 = _loc_13;
            if (_loc_13 == 64)
            {
                ApplicationDomain.currentDomain.domainMemory = _loc_3;
                Error.throwError(VerifyError, 1509);
            }
            _loc_10 = _loc_13;
            if ((++_loc_7 & 128) != 0)
            {
                ApplicationDomain.currentDomain.domainMemory = _loc_3;
                Error.throwError(VerifyError, 1509);
            }
            if (++_loc_7 == 61)
            {
                _loc_13 = -1;
            }
            else
            {
                _loc_13 = _loc_13;
                if (_loc_13 == 64)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
            }
            _loc_11 = _loc_13;
            if (_loc_11 != -1)
            {
                _loc_8 = ++_loc_8 + 1;
                _loc_7 = ++_loc_7 + 1;
                _loc_13 = _loc_7;
                if ((_loc_13 & 128) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                if (_loc_13 == 61)
                {
                    _loc_13 = -1;
                }
                else
                {
                    _loc_13 = _loc_13;
                    if (_loc_13 == 64)
                    {
                        ApplicationDomain.currentDomain.domainMemory = _loc_3;
                        Error.throwError(VerifyError, 1509);
                    }
                }
                _loc_12 = _loc_13;
                if (_loc_12 != -1)
                {
                }
            }
            else
            {
                if ((++_loc_7 & 128) != 0)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
                if (++_loc_7 == 61)
                {
                    _loc_13 = -1;
                }
                else
                {
                    _loc_13 = _loc_13;
                    if (_loc_13 == 64)
                    {
                        ApplicationDomain.currentDomain.domainMemory = _loc_3;
                        Error.throwError(VerifyError, 1509);
                    }
                }
                if (_loc_13 != -1)
                {
                    ApplicationDomain.currentDomain.domainMemory = _loc_3;
                    Error.throwError(VerifyError, 1509);
                }
            }
            ApplicationDomain.currentDomain.domainMemory = _loc_3;
            var _loc_14:* = new ByteArray();
            new ByteArray().writeBytes(_loc_4, 128, ++_loc_8 - 128 + 1);
            _loc_14.position = 0;
            return _loc_14;
        }// end function

    }
}
