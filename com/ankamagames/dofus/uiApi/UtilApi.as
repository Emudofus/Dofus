package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.berilia.types.data.UiModule;
    import flash.globalization.Collator;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.utils.misc.CallWithParameters;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.utils.ParamsDecoder;
    import flash.geom.ColorTransform;
    import com.ankamagames.berilia.components.Texture;
    import flash.display.DisplayObject;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import __AS3__.vec.*;

    [InstanciedApi]
    public class UtilApi implements IApi 
    {

        protected var _log:Logger;
        private var _module:UiModule;
        private var _stringSorter:Collator;

        public function UtilApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(UtilApi));
            super();
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
        }

        [Untrusted]
        public function callWithParameters(method:Function, parameters:Array):void
        {
            CallWithParameters.call(method, parameters);
        }

        [Untrusted]
        public function callConstructorWithParameters(callClass:Class, parameters:Array)
        {
            return (CallWithParameters.callConstructor(callClass, parameters));
        }

        [Untrusted]
        public function callRWithParameters(method:Function, parameters:Array)
        {
            return (CallWithParameters.callR(method, parameters));
        }

        [Untrusted]
        public function kamasToString(kamas:Number, unit:String="-"):String
        {
            return (StringUtils.kamasToString(kamas, unit));
        }

        [Untrusted]
        public function formateIntToString(val:Number):String
        {
            return (StringUtils.formateIntToString(val));
        }

        [Untrusted]
        public function stringToKamas(string:String, unit:String="-"):int
        {
            return (StringUtils.stringToKamas(string, unit));
        }

        [Untrusted]
        public function getTextWithParams(textId:int, params:Array, replace:String="%"):String
        {
            var msgContent:String = I18n.getText(textId);
            if (msgContent)
            {
                return (ParamsDecoder.applyParams(msgContent, params, replace));
            };
            return ("");
        }

        [Untrusted]
        public function applyTextParams(pText:String, pParams:Array, pReplace:String="%"):String
        {
            return (ParamsDecoder.applyParams(pText, pParams, pReplace));
        }

        [Trusted]
        public function noAccent(str:String):String
        {
            return (StringUtils.noAccent(str));
        }

        [Untrusted]
        public function changeColor(obj:Object, color:Number, depth:int, unColor:Boolean=false):void
        {
            var t0:ColorTransform;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:ColorTransform;
            if (obj != null)
            {
                if (unColor)
                {
                    t0 = new ColorTransform(1, 1, 1, 1, 0, 0, 0);
                    if ((obj is Texture))
                    {
                        Texture(obj).colorTransform(t0, depth);
                    }
                    else
                    {
                        if ((obj is DisplayObject))
                        {
                            DisplayObject(obj).transform.colorTransform = t0;
                        };
                    };
                }
                else
                {
                    _local_6 = ((color >> 16) & 0xFF);
                    _local_7 = ((color >> 8) & 0xFF);
                    _local_8 = ((color >> 0) & 0xFF);
                    _local_9 = new ColorTransform(0, 0, 0, 1, _local_6, _local_7, _local_8);
                    if ((obj is Texture))
                    {
                        Texture(obj).colorTransform(_local_9, depth);
                    }
                    else
                    {
                        if ((obj is DisplayObject))
                        {
                            DisplayObject(obj).transform.colorTransform = _local_9;
                        };
                    };
                };
            };
        }

        [Untrusted]
        public function sortOnString(list:*, field:String=""):void
        {
            if (((!((list is Array))) && (!((list is Vector.<*>)))))
            {
                this._log.error("Tried to sort something different than an Array or a Vector!");
                return;
            };
            if (!(this._stringSorter))
            {
                this._stringSorter = new Collator(XmlConfig.getInstance().getEntry("config.lang.current"));
            };
            if (field)
            {
                list.sort(function (a:*, b:*):int
                {
                    return (_stringSorter.compare(a[field], b[field]));
                });
            }
            else
            {
                list.sort(this._stringSorter.compare);
            };
        }

        [Untrusted]
        public function sort(target:*, field:String, ascendand:Boolean=true, isNumeric:Boolean=false)
        {
            var result:* = undefined;
            var sup:int;
            var inf:int;
            if ((target is Array))
            {
                result = (target as Array).concat();
                result.sortOn(field, (((ascendand) ? 0 : Array.DESCENDING) | ((isNumeric) ? Array.NUMERIC : Array.CASEINSENSITIVE)));
                return (result);
            };
            if ((target is Vector.<*>))
            {
                result = target.concat();
                sup = ((ascendand) ? 1 : -1);
                inf = ((ascendand) ? -1 : 1);
                if (isNumeric)
                {
                    result.sort(function (a:*, b:*):int
                    {
                        if (a[field] > b[field])
                        {
                            return (sup);
                        };
                        if (a[field] < b[field])
                        {
                            return (inf);
                        };
                        return (0);
                    });
                }
                else
                {
                    result.sort(function (a:*, b:*):int
                    {
                        var astr:String = a[field].toLocaleLowerCase();
                        var bstr:String = b[field].toLocaleLowerCase();
                        if (astr > bstr)
                        {
                            return (sup);
                        };
                        if (astr < bstr)
                        {
                            return (inf);
                        };
                        return (0);
                    });
                };
                return (result);
            };
            return (null);
        }

        [Untrusted]
        public function filter(target:*, pattern:*, field:String)
        {
            var searchFor:String;
            if (!(target))
            {
                return (null);
            };
            var result:* = new ((target.constructor as Class))();
            var len:uint = target.length;
            var i:uint;
            if ((pattern is String))
            {
                searchFor = String(pattern).toLowerCase();
                while (i < len)
                {
                    if (String(target[i][field]).toLowerCase().indexOf(searchFor) != -1)
                    {
                        result.push(target[i]);
                    };
                    i++;
                };
            }
            else
            {
                while (i < len)
                {
                    if (target[i][field] == pattern)
                    {
                        result.push(target[i]);
                    };
                    i++;
                };
            };
            return (result);
        }

        [Untrusted]
        public function getTiphonEntityLook(pEntityId:int):TiphonEntityLook
        {
            return (EntitiesLooksManager.getInstance().getTiphonEntityLook(pEntityId));
        }

        [Untrusted]
        public function getRealTiphonEntityLook(pEntityId:int, pWithoutMount:Boolean=false):TiphonEntityLook
        {
            return (EntitiesLooksManager.getInstance().getRealTiphonEntityLook(pEntityId, pWithoutMount));
        }

        [Untrusted]
        public function getLookFromContext(pEntityId:int, pForceCreature:Boolean=false):TiphonEntityLook
        {
            return (EntitiesLooksManager.getInstance().getLookFromContext(pEntityId, pForceCreature));
        }

        [Untrusted]
        public function getLookFromContextInfos(pInfos:GameContextActorInformations, pForceCreature:Boolean=false):TiphonEntityLook
        {
            return (EntitiesLooksManager.getInstance().getLookFromContextInfos(pInfos, pForceCreature));
        }

        [Untrusted]
        public function isCreature(pEntityId:int):Boolean
        {
            return (EntitiesLooksManager.getInstance().isCreature(pEntityId));
        }

        [Untrusted]
        public function isCreatureFromLook(pLook:TiphonEntityLook):Boolean
        {
            return (EntitiesLooksManager.getInstance().isCreatureFromLook(pLook));
        }

        [Untrusted]
        public function isIncarnation(pEntityId:int):Boolean
        {
            return (EntitiesLooksManager.getInstance().isIncarnation(pEntityId));
        }

        [Untrusted]
        public function isIncarnationFromLook(pLook:TiphonEntityLook):Boolean
        {
            return (EntitiesLooksManager.getInstance().isIncarnationFromLook(pLook));
        }

        [Untrusted]
        public function isCreatureMode():Boolean
        {
            return (EntitiesLooksManager.getInstance().isCreatureMode());
        }

        [Untrusted]
        public function getCreatureLook(pEntityId:int):TiphonEntityLook
        {
            return (EntitiesLooksManager.getInstance().getCreatureLook(pEntityId));
        }


    }
}//package com.ankamagames.dofus.uiApi

