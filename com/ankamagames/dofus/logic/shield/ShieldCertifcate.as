package com.ankamagames.dofus.logic.shield
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import avmplus.getQualifiedClassName;
    import flash.utils.IDataInput;
    import flash.utils.ByteArray;
    import com.ankamagames.dofus.network.types.secure.TrustCertificate;
    import by.blooddy.crypto.SHA256;
    import com.ankamagames.jerakine.utils.crypto.Base64;
    import com.hurlant.crypto.symmetric.AESKey;
    import com.hurlant.crypto.symmetric.ECBMode;
    import flash.system.Capabilities;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import flash.filesystem.File;
    import flash.system.ApplicationDomain;
    import by.blooddy.crypto.MD5;

    public class ShieldCertifcate 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ShieldCertifcate));
        public static const HEADER_BEGIN:String = "SV";
        public static const HEADER_V1:String = (HEADER_BEGIN + "1");
        public static const HEADER_V2:String = (HEADER_BEGIN + "2");
        public static const HEADER_V3:String = (HEADER_BEGIN + "3");

        public var version:uint;
        public var id:uint;
        public var content:String;
        public var useBasicNetworkInfo:Boolean;
        public var useAdvancedNetworkInfo:Boolean;
        public var useBasicInfo:Boolean;
        public var useUserInfo:Boolean;
        public var filterVirtualNetwork:Boolean;

        public function ShieldCertifcate(version:uint=3)
        {
            switch (version)
            {
                case 1:
                    this.useAdvancedNetworkInfo = false;
                    this.useBasicNetworkInfo = false;
                    this.useBasicInfo = false;
                    this.useUserInfo = false;
                    this.filterVirtualNetwork = false;
                    return;
                case 2:
                    this.useAdvancedNetworkInfo = true;
                    this.useBasicNetworkInfo = true;
                    this.useBasicInfo = true;
                    this.useUserInfo = true;
                    this.filterVirtualNetwork = false;
                    return;
                case 3:
                    this.useAdvancedNetworkInfo = false;
                    this.useBasicNetworkInfo = true;
                    this.useBasicInfo = true;
                    this.useUserInfo = true;
                    this.filterVirtualNetwork = true;
                    return;
            };
        }

        public static function fromRaw(data:IDataInput, output:ShieldCertifcate=null):ShieldCertifcate
        {
            var _local_5:uint;
            var i:uint;
            var result:ShieldCertifcate = ((output) ? output : new (ShieldCertifcate)());
            data["position"] = 0;
            var header:String = data.readUTFBytes(3);
            if (header.substr(0, 2) != HEADER_BEGIN)
            {
                header = HEADER_V1;
            };
            switch (header)
            {
                case HEADER_V1:
                    result.version = 1;
                    data["position"] = 0;
                    result.id = data.readUnsignedInt();
                    result.content = data.readUTF();
                    result.useAdvancedNetworkInfo = false;
                    result.useBasicNetworkInfo = false;
                    result.useBasicInfo = false;
                    result.useUserInfo = false;
                    result.filterVirtualNetwork = false;
                    break;
                case HEADER_V2:
                    result.version = 2;
                    result.id = data.readUnsignedInt();
                    result.useAdvancedNetworkInfo = true;
                    result.useBasicNetworkInfo = true;
                    result.useBasicInfo = true;
                    result.useUserInfo = true;
                    result.filterVirtualNetwork = false;
                    result.content = result.decrypt(data);
                    break;
                case HEADER_V3:
                    result.version = 3;
                    result.id = data.readUnsignedInt();
                    _local_5 = data.readShort();
                    i = 0;
                    while (i < _local_5)
                    {
                        result[data.readUTF()] = data.readBoolean();
                        i++;
                    };
                    result.content = result.decrypt(data);
                    break;
            };
            return (result);
        }


        public function set secureLevel(level:uint):void
        {
            switch (level)
            {
                case ShieldSecureLevel.LOW:
                    this.useAdvancedNetworkInfo = false;
                    this.useBasicNetworkInfo = false;
                    this.useBasicInfo = false;
                    this.useUserInfo = false;
                    this.filterVirtualNetwork = false;
                    return;
                case ShieldSecureLevel.MEDIUM:
                    this.useAdvancedNetworkInfo = false;
                    this.useBasicNetworkInfo = false;
                    this.useBasicInfo = true;
                    this.useUserInfo = true;
                    this.filterVirtualNetwork = false;
                    return;
                case ShieldSecureLevel.MAX:
                    this.useAdvancedNetworkInfo = true;
                    this.useBasicNetworkInfo = true;
                    this.useBasicInfo = true;
                    this.useUserInfo = true;
                    this.filterVirtualNetwork = true;
                    return;
            };
        }

        public function get hash():String
        {
            return (this.getHash());
        }

        public function get reverseHash():String
        {
            return (this.getHash(true));
        }

        public function serialize():ByteArray
        {
            var _local_2:Array;
            var i:uint;
            var result:ByteArray = new ByteArray();
            switch (this.version)
            {
                case 1:
                    throw (new Error("No more supported"));
                case 2:
                    result.writeUTFBytes(HEADER_V2);
                    result.writeUnsignedInt(this.id);
                    result.writeUTFBytes(this.content);
                    break;
                case 3:
                    result.writeUTFBytes(HEADER_V3);
                    result.writeUnsignedInt(this.id);
                    _local_2 = ["useBasicInfo", "useBasicNetworkInfo", "useAdvancedNetworkInfo", "useUserInfo"];
                    result.writeShort(_local_2.length);
                    i = 0;
                    while (i < _local_2.length)
                    {
                        result.writeUTF(_local_2[i]);
                        result.writeBoolean(this[_local_2[i]]);
                        i++;
                    };
                    result.writeUTFBytes(this.content);
                    break;
            };
            return (result);
        }

        public function toNetwork():TrustCertificate
        {
            var certif:TrustCertificate = new TrustCertificate();
            var hash:String = SHA256.hash((this.getHash() + this.content));
            certif.initTrustCertificate(this.id, hash);
            return (certif);
        }

        private function decrypt(data:IDataInput):String
        {
            //unresolved jump
            
        _label_1: 
            goto _label_9;
            
        _label_2: 
            var cryptedData:ByteArray = Base64.decodeToByteArray(data.readUTFBytes(data.bytesAvailable));
            goto _label_10;
            
        _label_3: 
            goto _label_1;
            var decrypt$0 = decrypt$0;
            
        _label_4: 
            var aesKey:AESKey = new AESKey(key);
            while (true)
            {
                var ecb:ECBMode = new ECBMode(aesKey);
                goto _label_6;
            };
            var _local_3 = _local_3;
            
        _label_5: 
            goto _label_4;
            var _local_4 = _local_4;
            
        _label_6: 
            goto _label_2;
            
        _label_7: 
            goto _label_8;
            goto _label_3;
            var _local_0 = this;
            
        _label_8: 
            key.writeUTFBytes(_local_0.getHash(true));
            goto _label_5;
            
        _label_9: 
            var key:ByteArray = new ByteArray();
            goto _label_7;
            try
            {
                
            _label_10: 
                ecb.decrypt(cryptedData);
            }
            catch(e:Error)
            {
                while (_log.error("Certificat V2 non valide (clef invalide)"), true)
                {
                    goto _label_11;
                };
                
            _label_11: 
                return (null);
            };
            cryptedData.position = 0;
            return (cryptedData.readUTFBytes(cryptedData.length));
        }

        private function getHash(reverse:Boolean=false):String
        {
            goto _label_6;
            
        _label_1: 
            goto _label_5;
            goto _label_1;
            var _local_6 = _local_6;
            
        _label_2: 
            var orderInterfaces:Array;
            while ((var netInterface:* = undefined), true)
            {
                var i:uint;
                //unresolved jump
                var _local_0 = this;
            };
            
        _label_3: 
            var data:Array = [];
            goto _label_7;
            
        _label_4: 
            var networkInterface:Object;
            var interfaces:* = undefined;
            goto _label_2;
            _local_0 = this;
            
        _label_5: 
            goto _label_3;
            
        _label_6: 
            var virtualNetworkRegExpr:RegExp;
            goto _label_4;
            
        _label_7: 
            if (_local_0.useBasicInfo)
            {
                while (data.push(Capabilities.cpuArchitecture), true)
                {
                    data.push(Capabilities.os);
                    //unresolved jump
                };
                var _local_5 = _local_5;
                
            _label_8: 
                goto _label_9;
                while (data.push(Capabilities.language), goto _label_8, (_local_0 = _local_0), true)
                {
                    data.push(Capabilities.maxLevelIDC);
                    continue;
                    var getHash$0 = getHash$0;
                };
            };
            
        _label_9: 
            if (AirScanner.hasAir())
            {
                if (_local_0.useUserInfo)
                {
                    try
                    {
                        data.push(File.documentsDirectory.nativePath.split(File.separator)[2]);
                    }
                    catch(e:Error)
                    {
                        _log.error("User non disponible.");
                    };
                };
                if (_local_0.useBasicNetworkInfo)
                {
                    virtualNetworkRegExpr = new RegExp("(6to4)|(adapter)|(teredo)|(tunneling)|(loopback)", "ig");
                    try
                    {
                        if (ApplicationDomain.currentDomain.hasDefinition("flash.net::NetworkInfo"))
                        {
                            //unresolved jump
                            
                        _label_10: 
                            interfaces = networkInterface.networkInfo.findInterfaces();
                            while (goto _label_11, (networkInterface = ApplicationDomain.currentDomain.getDefinition("flash.net::NetworkInfo")), true)
                            {
                                goto _label_10;
                            };
                            
                        _label_11: 
                            orderInterfaces = [];
                            for each (netInterface in interfaces)
                            {
                                //unresolved jump
                                var _local_4 = _local_4;
                            };
                            while (orderInterfaces.sortOn("hardwareAddress"), true)
                            {
                                goto _label_12;
                            };
                            
                        _label_12: 
                            i = 0;
                            while (i < orderInterfaces.length)
                            {
                                if (((_local_0.filterVirtualNetwork) && (!((String(orderInterfaces[i].displayName).search(virtualNetworkRegExpr) == -1)))))
                                {
                                }
                                else
                                {
                                    data.push(orderInterfaces[i].hardwareAddress);
                                    if (_local_0.useAdvancedNetworkInfo)
                                    {
                                        data.push(orderInterfaces[i].name);
                                        data.push(orderInterfaces[i].displayName);
                                        goto _label_14;
                                    };
                                };
                                
                            _label_13: 
                                i++;
                                continue;
                                
                            _label_14: 
                                goto _label_13;
                            };
                        };
                    }
                    catch(e:Error)
                    {
                        _log.error("Donnée sur la carte réseau non disponible.");
                    };
                };
            };
            if (reverse)
            {
                while (data.reverse(), true)
                {
                    goto _label_15;
                };
                var _local_3 = _local_3;
            };
            
        _label_15: 
            return (MD5.hash(data.toString()));
        }

        private function traceInfo(target:*, maxDepth:uint=5, inc:String=""):void
        {
            _loop_1:
            for (;;)
            {
                _log.info(("displayName : " + target.displayName));
                goto _label_9;
                
            _label_1: 
                goto _label_7;
                
            _label_2: 
                _log.info("-----------");
                goto _label_1;
                var _local_0 = this;
                
            _label_3: 
                _log.info(("parent : " + target.parent));
                for (;;)
                {
                    
                _label_4: 
                    _log.info(("name : " + target.hardwareAddress));
                    continue _loop_1;
                    goto _label_8;
                    
                _label_5: 
                    _log.info(("hardwareAddress : " + target.hardwareAddress));
                    continue;
                    goto _label_11;
                };
                var _local_5 = _local_5;
                
            _label_6: 
                goto _label_2;
                
            _label_7: 
                _log.info(("active : " + target.active));
                goto _label_10;
                
            _label_8: 
                goto _label_6;
                
            _label_9: 
                goto _label_3;
                
            _label_10: 
                goto _label_5;
            };
            
        _label_11: 
            if (((target.parent) && (maxDepth)))
            {
                while (this.traceInfo(target.parent, maxDepth--, (inc + "...")), true)
                {
                    return;
                };
            };
            return;
        }


    }
}//package com.ankamagames.dofus.logic.shield

