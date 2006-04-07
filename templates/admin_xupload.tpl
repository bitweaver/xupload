{strip}

{jstabs}
	{jstab title="XUpload Features"}
		{form legend="XUpload Features"}
			<input type="hidden" name="page" value="{$page}" />

			{foreach from=$formXuploadFeatures key=item item=output}
				<div class="row">
					{formlabel label=`$output.label` for=$item}
					{forminput}
						<input type="text" name="{$item}" id="$item" size="25" value="{$gBitSystem->getConfig($item)|escape}" />
						{formhelp note=`$output.note` page=`$output.page`}
					{/forminput}
				</div>
			{/foreach}
			<div class="row submit">
				<input type="submit" name="xupload_features" value="{tr}Change preferences{/tr}" />
			</div>
		{/form}
	{/jstab}
{/jstabs}

{/strip}
