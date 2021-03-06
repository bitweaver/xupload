{strip}
{form legend="XUpload Features"}
	<input type="hidden" name="page" value="{$page}" />

	{foreach from=$formXuploadFeatures key=item item=output}
		<div class="row">
			{formlabel label=`$output.label` for=$item}
			{forminput}
				{if $output.type == 'text'}
					<input type='text' name="{$item}" id="{$item}" size="40" value="{$gBitSystem->getConfig($item)|escape}" />
				{else}
					{html_checkboxes name="$item" values="y" checked=$gBitSystem->getConfig($item) labels=false id=$item}
				{/if}
				{formhelp note=`$output.note` page=`$output.page`}
			{/forminput}
		</div>
	{/foreach}
	<div class="row submit">
		<input type="submit" name="xupload_features" value="{tr}Change preferences{/tr}" />
	</div>
{/form}
{/strip}
