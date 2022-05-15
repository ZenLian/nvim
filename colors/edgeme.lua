-- clear cache so this reloads changes.
-- useful for development
package.loaded['edgeme'] = nil
package.loaded['edgeme.config'] = nil
package.loaded['edgeme.util'] = nil
package.loaded['edgeme.palette'] = nil
package.loaded['edgeme.theme'] = nil

require('edgeme').load()
