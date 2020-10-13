<aura:application >
    <aura:attribute name="valueA" type="String" default="Hey, Jude" />
    <aura:attribute name="valueB" type="String" />
    <aura:attribute name="valueC" type="String" />
    <aura:attribute name="valueD" type="String" />

    <aura:handler name="init" value="{!this}" action="{!c.init}" />

    <lightning:input name="reflect" value="{!v.valueA}" label="Current Value" />
    <lightning:input name="valuea" disabled="{!true}" value="{!v.valueA}" label="Value" />
    <lightning:input name="valueb" disabled="{!true}" value="{!v.valueB}" label="getReference" />
    <lightning:input name="valuec" disabled="{!true}" value="{!v.valueC}" label="get" />
    <lightning:input name="valued" disabled="{!true}" value="{!v.valueD}" label="get1" />

</aura:application>