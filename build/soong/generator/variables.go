package generator

import (
	"fmt"

	"android/soong/android"
)

func komodoExpandVariables(ctx android.ModuleContext, in string) string {
	komodoVars := ctx.Config().VendorConfig("komodoVarsPlugin")

	out, err := android.Expand(in, func(name string) (string, error) {
		if komodoVars.IsSet(name) {
			return komodoVars.String(name), nil
		}
		// This variable is not for us, restore what the original
		// variable string will have looked like for an Expand
		// that comes later.
		return fmt.Sprintf("$(%s)", name), nil
	})

	if err != nil {
		ctx.PropertyErrorf("%s: %s", in, err.Error())
		return ""
	}

	return out
}
