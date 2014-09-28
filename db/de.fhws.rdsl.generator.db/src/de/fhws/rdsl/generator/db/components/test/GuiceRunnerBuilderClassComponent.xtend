package de.fhws.rdsl.generator.db.components.test

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class GuiceRunnerBuilderClassComponent extends AbstractComponent {

	override protected createJavaClass() {

		return new JavaClass => [
			name = "GuiceRunnerBuilder"
			pckg = dbTestPckg
			content = '''
public class «name» extends org.junit.runners.model.RunnerBuilder {

    private com.google.inject.Module module;

    public GuiceRunnerBuilder(com.google.inject.Module module) {
        super();
        this.module = module;
    }

    @Override
    public org.junit.runner.Runner runnerForClass(Class<?> testClass) throws Throwable {
        return new BlockTestRunner(testClass, this.module);
    }

    private static class BlockTestRunner extends org.junit.runners.BlockJUnit4ClassRunner {

        private com.google.inject.Injector injector;

        public BlockTestRunner(Class<?> klass, com.google.inject.Module module) throws org.junit.runners.model.InitializationError {
            super(klass);
            this.injector = com.google.inject.Guice.createInjector(module);
        }

        @Override
        protected Object createTest() throws Exception {
            return this.injector.getInstance(getTestClass().getJavaClass());
        }

    }

}
			'''
		]
	}

}
