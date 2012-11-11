package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.tooltip.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.modules.utils.*;
    import com.ankamagames.dofus.types.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class TooltipApi extends Object implements IApi
    {
        private var _module:UiModule;
        private var _currentUi:UiRootContainer;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TooltipApi));

        public function TooltipApi()
        {
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function set currentUi(param1:UiRootContainer) : void
        {
            this._currentUi = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            this._currentUi = null;
            return;
        }// end function

        public function setDefaultTooltipUiScript(param1:String, param2:String) : void
        {
            var _loc_3:* = UiModuleManager.getInstance().getModule(param1);
            if (!_loc_3)
            {
                throw new ApiError("Module " + param1 + " doesn\'t exist");
            }
            var _loc_4:* = _loc_3.getUi(param2);
            if (!_loc_3.getUi(param2))
            {
                throw new ApiError("UI " + param2 + " doesn\'t exist in module " + param1);
            }
            TooltipManager.defaultTooltipUiScript = _loc_4.uiClass;
            return;
        }// end function

        public function createTooltip(param1:String, param2:String, param3:String = null) : Tooltip
        {
            var _loc_4:* = null;
            if (param1.substr(-4, 4) != ".txt")
            {
                throw new ApiError("ChunkData support only [.txt] file, found " + param1);
            }
            if (param2.substr(-4, 4) != ".txt")
            {
                throw new ApiError("ChunkData support only [.txt] file, found " + param2);
            }
            if (param3)
            {
                if (param3.substr(-4, 4) != ".txt")
                {
                    throw new ApiError("ChunkData support only [.txt] file, found " + param3);
                }
                _loc_4 = new Tooltip(new Uri(this._module.rootPath + "/" + param1), new Uri(this._module.rootPath + "/" + param2), new Uri(this._module.rootPath + "/" + param3));
            }
            else
            {
                _loc_4 = new Tooltip(new Uri(this._module.rootPath + "/" + param1), new Uri(this._module.rootPath + "/" + param2));
            }
            return _loc_4;
        }// end function

        public function createTooltipBlock(param1:Function, param2:Function) : TooltipBlock
        {
            var _loc_3:* = new TooltipBlock();
            _loc_3.onAllChunkLoadedCallback = param1;
            _loc_3.contentGetter = param2;
            return _loc_3;
        }// end function

        public function registerTooltipAssoc(param1, param2:String) : void
        {
            TooltipsFactory.registerAssoc(param1, param2);
            return;
        }// end function

        public function registerTooltipMaker(param1:String, param2:Class, param3:Class = null) : void
        {
            if (CheckCompatibility.isCompatible(ITooltipMaker, param2))
            {
                TooltipsFactory.registerMaker(param1, param2, param3);
            }
            else
            {
                throw new ApiError(param1 + " maker class is not compatible with ITooltipMaker");
            }
            return;
        }// end function

        public function createChunkData(param1:String, param2:String) : ChunkData
        {
            var _loc_3:* = new Uri(this._module.rootPath + "/" + param2);
            if (_loc_3.fileType.toLowerCase() != "txt")
            {
                throw new ApiError("ChunkData support only [.txt] file, found " + param2);
            }
            return new ChunkData(param1, _loc_3);
        }// end function

        public function place(param1, param2:uint = 6, param3:uint = 0, param4:int = 3) : void
        {
            if (param1 && CheckCompatibility.isCompatible(IRectangle, param1))
            {
                TooltipPlacer.place(this._currentUi, param1, param2, param3, param4);
            }
            return;
        }// end function

        public function placeArrow(param1) : Object
        {
            if (param1 && CheckCompatibility.isCompatible(IRectangle, param1))
            {
                return TooltipPlacer.placeWithArrow(this._currentUi, param1);
            }
            return null;
        }// end function

        public function getSpellTooltipInfo(param1:SpellWrapper, param2:String = null) : Object
        {
            return new SpellTooltipInfo(param1, param2);
        }// end function

        public function getItemTooltipInfo(param1:ItemWrapper, param2:String = null) : Object
        {
            return new ItemTooltipInfo(param1, param2);
        }// end function

        public function getSpellTooltipCache() : int
        {
            return PlayedCharacterUpdatesFrame.SPELL_TOOLTIP_CACHE_NUM;
        }// end function

        public function resetSpellTooltipCache() : void
        {
            var _loc_1:* = PlayedCharacterUpdatesFrame;
            var _loc_2:* = PlayedCharacterUpdatesFrame.SPELL_TOOLTIP_CACHE_NUM + 1;
            _loc_1.SPELL_TOOLTIP_CACHE_NUM = _loc_2;
            return;
        }// end function

        public function createTooltipRectangle(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : TooltipRectangle
        {
            return new TooltipRectangle(param1, param2, param3, param4);
        }// end function

        public function createSpellSettings() : SpellTooltipSettings
        {
            return new SpellTooltipSettings();
        }// end function

        public function createItemSettings() : ItemTooltipSettings
        {
            return new ItemTooltipSettings();
        }// end function

    }
}
