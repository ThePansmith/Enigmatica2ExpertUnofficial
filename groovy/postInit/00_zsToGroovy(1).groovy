import groovy.io.FileType

def workingDir = new File('transform')

if (!workingDir.exists()) {
    workingDir.mkdir()
}

workingDir.eachFileRecurse (FileType.FILES) { file ->
    if (file.name.endsWith('.zs')) {
        new File(file.path.replace('.zs', '.groovy')).with { newFile ->
            newFile.delete()
            newFile.createNewFile()
            newFile.withWriter { w ->
                w << file.text
                    .replace('#modloaded', '//MOD_LOADED')
                    .replace(";${System.getProperty("line.separator")}", System.getProperty("line.separator"))
                    .replace('"', '\'')
                    .replace('{', '[')
                    .replace('}', ']')
                    .replace('<ore:', 'ore(\'') // Oredicts
                    .replace('<blockstate:', 'blockstate(\'') // Blockstates
                    .replace('<entity:', 'entity(\'') // Entities
                    .replace('<metaitem:', 'metaitem(\'') // Meta Items
                    .replace('<meta_tile_entity:', 'metaitem(\'') // Meta Tile Entities (Use Meta Item)
                    .replace('<liquid:', 'fluid(\'')
                    .replace('<recipemap:', 'mods.gregtech.')
                    .replace('<', 'item(\'') // Items
                    .replace('>', '\')')
                    .replace('.circuit', '.circuitMeta')
                    .replace('val', 'def')
                    .replace('function', 'def')
                    .replace('recipes.removeByRecipeName', 'crafting.remove')
                    .replace('recipes.remove', 'crafting.removeByOutput')
                    .replace('recipes', 'crafting')
                    .replace(".withTag", '.withNbt')
                    .replaceAll( // Unnecessary casts
                        / as IItemStack\[\]/, ''
                    )
                    .replaceAll(
                        / as void/, ''
                    )
                    .replaceAll( // Metadata
                        /:([\d]*)'(?=\))/, /', $1/
                    )
                    .replaceAll( // For loops
                        /for\s([^\(\)]*)(?:(\S(?=\{))|\s((?=\{)))/,
                        /for ($1$2$3) /
                    )
                    .replaceAll( // Events
                        /events\..*\(function\(event as (.*)\) \{([\s\S]*\})\)/,
                        /event_manager.listen { $1 event ->$2/
                    )
                    .replaceAll( // Not null checks
                        /!isNull(\([^\)]*(?=\)))/,
                        /$1 != null/
                    )
                    .replaceAll( // Null checks
                        /isNull(\([^\)]*(?=\)))/,
                        /$1 == null/
                    )
                    .replaceAll( // Item Metas
                        /item\('([a-z_0-9]+):([a-z_0-9]+):([0-9]+)/,
                        /item('\u00241:\u00242', \u00243)/
                    )
            }
        }
    }
}
println('Done!')
