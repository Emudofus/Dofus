package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IStatsClass;
    import com.ankamagames.berilia.types.data.Hook;

    public interface IUiStats extends IStatsClass 
    {

        function onHook(_arg_1:Hook, _arg_2:Array):void;

    }
}//package com.ankamagames.dofus.misc.stats.ui

